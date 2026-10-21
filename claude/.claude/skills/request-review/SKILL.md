---
name: request-review
description: Request human review on the current branch's GitHub pull request. For a PR nobody has reviewed yet, it asks the user who should review (unless the request already names reviewers), checks that the description still matches the changes and rewrites it if not, requests review from the chosen people, marks the PR ready for review, and posts a short comment asking them to take a look. For a PR that already has reviews, it re-requests review from the people who reviewed it, plus anyone the user names, and posts a short comment asking them to look again. Use when asked to "request review", "request a review", "ask for review", "re-request review", or "send this for review".
---

# Request review

Ask the team to review the pull request for the current branch. What the skill
does depends on whether anyone has reviewed the PR yet.

## Team usernames

Use this table to turn the names the user gives into GitHub usernames. Nobody
on it is a default reviewer: request review only from the people the user
chooses.

| Person          | GitHub username |
| --------------- | --------------- |
| Al Chou         | `HotFusionMan`  |
| Grant Stannard  | `GrantStannard` |
| Joe Goldwasser  | `joegoldwasser` |
| Michael Bourke  | `bourke`        |
| Randy Frutos    | `ouryuk`        |
| Scott D'Antuono | `escosio`       |
| Simon Rentzke   | `simonrentzke`  |

For a name that isn't in the table, look it up among the repository's
collaborators by their GitHub display name:

```bash
gh api "repos/$repo/collaborators" --paginate --jq '.[].login' \
  | while read -r login; do
      printf '%s\t%s\n' "$login" "$(gh api "users/$login" --jq '.name // ""')"
    done
```

If a name matches nobody, or more than one person, ask the user which username
they mean rather than guessing.

## Steps

### 1. Find the PR

```bash
branch=$(git branch --show-current)
gh pr view --json number,url,title,body,isDraft,state,author,baseRefName,headRefName,reviewRequests
```

`gh pr view` with no argument finds the PR whose head is the current branch.

- If there is no PR for the branch, stop and say so. Offer to open one with the
  `create-pr` skill.
- If the PR is merged or closed, stop and say so.
- If the PR author is not the signed-in user (`gh api user --jq .login`), stop
  and confirm with the user before changing someone else's PR.
- If the local branch has commits the remote does not
  (`git rev-list --count "@{upstream}..HEAD"` is above 0), the reviewers would
  see stale code. Tell the user and ask whether to push first. Do not push
  without asking.

### 2. Decide whether the PR has been reviewed

List the people who have submitted a review, using the REST API because it says
whether each reviewer is a person or a bot:

```bash
repo=$(gh repo view --json nameWithOwner --jq .nameWithOwner)
author=$(gh pr view --json author --jq .author.login)
gh api "repos/$repo/pulls/<number>/reviews" --paginate \
  --jq '.[] | select(.user.type == "User" and .state != "PENDING") | .user.login' \
  | sort -u | grep -vx "$author"
```

Leave out:

- bots, such as Copilot (`user.type` is `Bot`)
- the PR author, because replying to a review thread creates a review in the
  author's name
- `PENDING` reviews, which are unsubmitted drafts

If the list is empty, the PR has not been reviewed: follow step 3. Otherwise,
follow step 4 with the people on the list.

### 3. PR not reviewed yet

#### 3a. Choose the reviewers

Settle who reviews before changing anything on the PR.

- If the user's request names reviewers ("request review from Joe and Simon"),
  use exactly those people. Don't ask again.
- Otherwise, ask the user who should review this PR, and wait for the answer.
  If the PR already has requested reviewers (`reviewRequests` from step 1),
  name them in the question so the user can keep them, add to them, or replace
  them. Don't pick reviewers yourself, and don't fall back to a fixed list.

Turn each name into a GitHub username with the [team table](#team-usernames),
or the collaborator lookup below it. Leave out the PR author, because GitHub
does not let an author review their own PR.

#### 3b. Make sure the description matches the changes

Read what the PR contains now:

```bash
gh pr view <number> --json commits --jq '.commits[] | .messageHeadline'
gh pr diff <number> --name-only
gh pr diff <number>
```

Compare the description with the changes in both directions:

- Every claim in the description must still be true of the diff. Look for files,
  functions, or behavior the description mentions but the diff no longer
  contains or does differently.
- Every change a reviewer needs to know about must be in the description. Look
  for later commits that added scope, changed the approach, or reverted part of
  the original plan.

If the description is accurate, leave it alone and say so in the report.

If it is out of date, rewrite it by following the writing rules in step 5 of
the `create-pr` skill (`~/.claude/skills/create-pr/SKILL.md`). Two of those
rules matter most here: never add a testing section, and never mention Claude
or AI. Also:

- Keep the parts that are still accurate rather than starting from scratch.
- Keep existing screenshots and their `<details>` blocks when they still show
  the current UI. If one shows UI that has since changed, drop it and tell the
  user, rather than leaving an outdated picture in the PR.
- Keep the Jira link. If the title no longer describes the change, fix it too,
  using the `create-pr` title format (`<TICKET>: <short description>`).

Write the new body to a file and apply it:

```bash
gh pr edit <number> --body-file "$tmp/pr-body.md"
```

#### 3c. Add the reviewers

Add the people chosen in step 3a:

```bash
gh pr edit <number> --add-reviewer <login>,<login>
```

If the user chose to drop someone who was already requested, remove them:

```bash
gh pr edit <number> --remove-reviewer <login>
```

#### 3d. Mark the PR ready for review

If the PR is a draft:

```bash
gh pr ready <number>
```

#### 3e. Post the request

Post a short comment that @-mentions each reviewer and asks them to review
whenever they have a chance. Write it the way a teammate would: one or two
sentences, friendly, no headings or lists. Vary the wording from PR to PR.
Don't summarize the PR again, since the description already does that.

Example:

> @bourke @simonrentzke this one's ready for review. Could you take a look
> whenever you have a chance? Thanks!

```bash
gh pr comment <number> --body-file "$tmp/comment.md"
```

### 4. PR already reviewed

#### 4a. Re-request review

Re-request review from each person on the step 2 list, plus anyone the user's
request names:

```bash
gh api -X POST "repos/$repo/pulls/<number>/requested_reviewers" \
  -f 'reviewers[]=<login>' -f 'reviewers[]=<login>'
```

This endpoint re-requests a review from someone who has already reviewed, which
is what turns their review status back to pending on GitHub. Don't add anyone
who never reviewed this PR unless the user names them. Don't change the
description or the draft state in this case. If the PR is still a draft,
mention it in the report and leave it as it is.

#### 4b. Post the request

Post a short comment that @-mentions the people you re-requested and asks them
to take another look whenever they have a chance. If there are commits newer
than the latest review, it is accurate to say you pushed updates. Otherwise,
just ask for another look. Don't claim that feedback was addressed unless the
commits or the user say it was.

Example:

> @escosio @ouryuk I pushed some updates since your review. Could you take
> another look whenever you have a chance? Thanks!

```bash
gh pr comment <number> --body-file "$tmp/comment.md"
```

### 5. Report

Report the PR URL and what the skill did:

- whether the description was updated, and in one line, what changed
- who was requested or re-requested
- whether the PR was marked ready
- the comment text that was posted

Keep it short.
