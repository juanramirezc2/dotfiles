---
name: pr-review
description: Review someone else's GitHub pull request end to end. Checks the PR out into its own worktree, installs dependencies, runs the project's deep-review skill for code findings, runs browser-validate against what the PR description claims, cross-references the two, and drafts a review message for the user to approve before anything is posted. Use when asked to "review this PR", "PR review", "review #1234", "take a look at this pull request", or "is this PR safe to merge".
---

# PR review

Review a pull request as a careful colleague would: read the code, run the
app, check that the PR does what its description says, and hand the user a
review they can post. This skill orchestrates two others, `deep-review`
(project-level, code findings) and `browser-validate` (user-level, UI checks).
It does not reimplement either.

**Nothing is posted to GitHub by this skill.** The output is a draft. The user
posts it, or tells you to, in a separate step.

## Requirements

- `gh` signed in to github.com, recent enough to have `gh pr checkout --worktree`.
  Check with `gh pr checkout --help | grep -q -- --worktree` and stop with a
  clear message if the flag is missing.
- Run from inside the main clone of the repo the PR belongs to, so `gh` can
  resolve the repository and the worktree shares its object store.
- `playwright-cli` on PATH, and a way to run the app locally. `browser-validate`
  covers the browser side and its own requirements.
- The project's `deep-review` skill at `.claude/skills/deep-review/` in the
  repo. If absent, see "When the project has no deep-review skill" below.

## Paths

One PR, one set of files, all keyed by PR number:

```text
/workspace/pr-<number>/                     # worktree (sibling of other /workspace checkouts)
/workspace/pr-<number>-deep-review.md       # deep-review findings, saved locally
/workspace/pr-<number>-browser-validate.md  # browser-validate report
/workspace/pr-<number>-shots/               # screenshots from browser-validate
/workspace/pr-<number>-review-draft.md      # the review message for the user
```

If `/workspace` does not exist or is not writable, use a sibling directory of
the main clone instead (`../pr-<number>`) and keep the same file naming. Say
which you used.

## Steps

### 1. Read the PR before touching anything

```bash
gh pr view <number> --json number,title,body,author,headRefName,baseRefName,url,isDraft,files
gh pr diff <number> --stat
```

Record the author login, the head branch, the base branch, and the PR URL.
Read the body carefully. The body is the contract this review tests. Pull out,
as a numbered list:

- every behavior the PR claims to add, fix, or change
- every item under "Verification", "Testing", "How to test", or similar
- every screenshot or recording the author attached, and what it is meant to
  show
- the Jira ticket key if present (`[A-Z][A-Z0-9]+-[0-9]+` in title, body, or
  branch name)

This list drives Step 5. If the body is empty or says only "see ticket", say so
in the draft and derive claims from the ticket and the diff instead.

If the PR author is the current `gh` user, stop and say so. GitHub does not
allow reviewing your own PR, and the author should run `deep-review` directly.

### 2. Check the PR out into a worktree

Prefer naming the worktree branch after the PR's head branch. `deep-review`
detects "already on the PR branch" and reviews in place without trying to check
out again.

```bash
head=$(gh pr view <number> --json headRefName --jq .headRefName)
wt=/workspace/pr-<number>

gh pr checkout <number> --branch "$head" --worktree "$wt" \
  || gh pr checkout <number> --worktree "$wt"
```

The fallback runs when the head branch is already checked out somewhere else
(a worktree can hold a branch only once). In that case the worktree lands on a
branch named `pr-<number>`. Note which happened; it matters in Step 4.

If `$wt` already exists from an earlier review of the same PR, do not delete
it. Enter it, fetch, and fast-forward to the PR's current head:

```bash
cd "$wt" && git fetch origin && git merge --ff-only FETCH_HEAD 2>/dev/null || gh pr checkout <number>
git log -1 --format='%H %s'
```

Record the HEAD SHA. Every artifact names it, so the user knows exactly what
was reviewed.

### 3. Install dependencies

Work from inside the worktree. Pick the package manager the repo declares, in
this order:

1. `packageManager` field in `package.json` (`pnpm@…`, `yarn@…`, `npm@…`)
2. lockfile present: `pnpm-lock.yaml`, `yarn.lock`, `package-lock.json`,
   `bun.lockb`
3. README or CONTRIBUTING instructions
4. Non-JS projects: `Gemfile.lock` → `bundle install`, `poetry.lock` →
   `poetry install`, `requirements.txt` → a venv plus `pip install -r`,
   `go.mod` → `go mod download`, `Cargo.lock` → `cargo fetch`

```bash
cd "$wt"
grep -o '"packageManager": *"[^"]*"' package.json
ls pnpm-lock.yaml yarn.lock package-lock.json bun.lockb 2>/dev/null
pnpm install --frozen-lockfile     # or the equivalent for the manager found
```

Use the frozen-lockfile variant so the install reflects the PR, not whatever
the resolver picks today. If the install fails, report the error verbatim in
the draft as a finding and continue with the code review. Do not patch the
lockfile.

Copy environment files the app needs (`.env`, `.env.local`) from the main
clone if they are gitignored there and the project expects them. Never commit
them and never paste their contents.

### 4. Run deep-review

`deep-review` is a project skill, so it is only available when Claude Code was
started in a repo that has it. Check both routes:

- If `/deep-review` is listed among available skills, invoke it with the PR
  number: `/deep-review <number>`. Add a focus argument when the user asked for
  one (`/deep-review <number> security`).
- If it is not listed but `"$wt"/.claude/skills/deep-review/SKILL.md` exists,
  read that file and follow its steps directly, from inside the worktree.

Tell deep-review, in your own words when following it manually, that the
worktree is already on the PR's branch and it should review in place. If
Step 2 fell back to a `pr-<number>` branch, deep-review may want to run
`gh pr checkout` itself. Let it; the worktree is disposable.

**Do not submit.** When deep-review reaches its submit prompt ("Submit this
review?"), answer **no**. The submit decision belongs to the user at Step 7 of
this skill, after the browser results are in. If deep-review runs in a mode
that skips the prompt, nothing changes.

Save the full deep-review output, including the recommendation block, its
Blocking / Non-blocking / Pre-existing lists, and any AC completeness
advisory, to `/workspace/pr-<number>-deep-review.md`. Head the file with the
PR number, ticket, HEAD SHA, and date.

#### When the project has no deep-review skill

Do a code review yourself, scoped the same way:

1. `gh pr diff <number>` and read the whole thing.
2. Run the project's lint, typecheck, and the test files the PR touches or
   adds. Record pass/fail with output.
3. Look for: behavior changes the body does not mention, error paths that
   swallow failures, missing tests for new logic, and anything the base
   branch's `CLAUDE.md` or contributing rules forbid.
4. Classify each finding `critical`, `important`, or `suggestion`, and label
   pre-existing issues separately from ones the PR introduces.

Say in the draft that deep-review was unavailable and this was a manual pass.

### 5. Run browser-validate against the PR's claims

Invoke the `browser-validate` skill from inside the worktree, with the claim
list from Step 1 as the checklist. This is not a smoke test. Each check is one
claim from the body, phrased as something a browser can confirm or refute:

```text
Claim 1 (body, "Verification" #2): expanding an empty right column no longer shows a full-screen button
  → go to the route, expand the column, assert zero "full screen" buttons

Claim 2 (body, screenshot 1): the plan card updates in place after save
  → fill the form, save, assert the card value changed without a reload
```

Guidance:

- Start the app the way the repo documents, from the worktree, on a port that
  does not collide with the main clone if it is running. Say which URL you
  used.
- Use the worktree's own `.playwright/` for storage state, per
  browser-validate. Loading the main clone's state file is fine when the apps
  share an auth cookie.
- Give every claim a result: **PASS**, **FAIL**, or **UNTESTED** with a reason
  (needs data you cannot create, needs a third-party service, not reachable in
  a browser). Never silently drop a claim.
- Also check the one or two regressions the diff most plausibly causes, and
  label them as your additions, not the author's claims.
- Screenshots go to `/workspace/pr-<number>-shots/`. Take them for every FAIL
  and for any PASS the draft will cite.

Write the report to `/workspace/pr-<number>-browser-validate.md`: a header
with PR, ticket, branch, SHA, URL, date, then a table with one row per claim
(claim, source in the body, result, evidence file).

If the PR has no browser-visible surface (backend only, config, tooling,
tests), skip this step, say so in the draft, and go to Step 6.

### 6. Cross-reference

Put the two reports side by side and sort every item into one of four buckets:

| Bucket | Meaning |
| --- | --- |
| **Agree** | Code finding and browser result point the same way. Highest confidence. |
| **Disagree** | Code review flagged it but the browser shows it working, or the browser failed where the code looked fine. Dig in before the draft: re-read the diff, re-run the check, find out which is right. |
| **Browser only** | A browser FAIL or regression with no matching code finding. Trace it to a line in the diff if you can. |
| **Untested** | A claim from the PR description that browser-validate did not cover (skipped, forgotten, or marked UNTESTED without a hard reason such as "no browser surface"). |

Resolve every Disagree before writing the draft. A review that contradicts
itself is worse than one that says "unverified".

**Mandatory blockers from browser-validate (treat as `important` Blocking
items, even when deep-review found nothing):**

1. **Missed PR-description features.** Every user-facing behavior the PR body
   claims to add, fix, or change must appear as a row in the browser-validate
   report. If a claimed feature was never exercised in browser-validate
   (absent from the table, or left UNTESTED without a hard reason such as
   backend-only / no UI surface / blocked by missing credentials the author
   did not provide), add a Blocking item naming the claim and that it was not
   browser-validated. Do not bury these under "Untested claims" only — they
   are blockers.
2. **Regressions found in browser-validate.** Any FAIL that shows broken
   behavior introduced or worsened by this PR (including broken adjacent
   flows you hit while checking claims, even if the author did not list them)
   is a Blocking item. Cite the screenshot or reproduction steps. Pre-existing
   broken behavior that this PR did not touch stays Pre-existing
   (informational), not Blocking.

Then decide the recommendation using deep-review's rule plus those browser
rules: any `critical` or `important` finding introduced by the PR, any
browser FAIL / regression above, or any missed PR-description feature above,
means **Request changes**. Suggestions only means **Approve with comment**.
Nothing means **Approve**. True AC completeness gaps that are not claimed
behaviors in the PR body remain advisory and do not drive the recommendation
on their own.

### 7. Draft the review for the user

Write the draft to `/workspace/pr-<number>-review-draft.md` and print it in
chat in full. Format:

```markdown
# Review draft: PR #<number> <title>
<PR URL> · author @<login> · <head> → <base> · reviewed at <sha> on <date>

**Recommendation: <Approve | Approve with comment | Request changes>**

<one or two sentences: what the PR does and the overall verdict>

## Blocking
- [critical|important] <finding> (`path/to/file.ts:123`) — <browser evidence if any>

## Verified in the browser
| Claim | Result | Evidence |
| --- | --- | --- |
| <claim from body> | PASS | `pr-<number>-shots/03-thing.png` |

## Untested claims
- <claim> — <why>

## Non-blocking
- [suggestion] <finding>

## Pre-existing (informational)
- <issue the PR touches but did not introduce>

---
Sources: pr-<number>-deep-review.md, pr-<number>-browser-validate.md
```

Rules for the draft:

- Written to the author, in the user's voice, as one engineer to another.
  Plain prose, specific file and line references, no hedging where the
  evidence is clear.
- Every blocking item names the evidence: a line in the diff, a failing
  test, a screenshot, or — for a missed claim — the exact PR-description
  sentence that was never browser-validated. No blocking item on vibes.
- Blocking must include: (a) deep-review critical/important findings
  introduced by the PR, (b) every PR-description feature not covered in
  browser-validate without a hard skip reason, and (c) every regression or
  FAIL found during browser-validate that this PR introduced or worsened.
- Empty sections are removed, except **Blocking**, which says "None found"
  when empty so the reader knows it was looked for.
- **Never mention Claude, an AI, an assistant, or skill names** in the draft.
  The user will paste it as their own review.
- Do not include cookie values, tokens, env contents, or local hostnames with
  credentials.

End the chat message with exactly this question and nothing after it:

> Post this as **<recommendation>** on PR #<number>? (yes / edit / no)

### 8. Stop

Do not run `gh pr review`, `gh pr comment`, or anything that writes to GitHub
until the user answers **yes** or asks you to post. On **edit**, apply the
change to the draft file, reprint it, and ask again. On **no**, leave all
files in place and say where they are.

When the user says yes (or standing instructions already authorize posting
without asking), post with the body from the draft file and the
recommendation they confirmed:

```bash
gh pr review <number> --request-changes --body-file /workspace/pr-<number>-review-draft.md
# or --approve, or --comment for a non-verdict comment
```

Strip the `# Review draft:` header line and the `Sources:` footer before
posting.

### 9. Clean up after the review is submitted

Only after `gh pr review` (or equivalent) succeeds: if the review was an
**Approve** (including approve-with-comment / **should fix** notes), unsubscribe
from that PR's notifications; then stop every server you started for this PR
and delete the worktree. Leave the report artifacts
(`pr-<number>-deep-review.md`, `pr-<number>-browser-validate.md`,
`pr-<number>-review-draft.md`, `pr-<number>-shots/`) in place.

```bash
# After a successful approve only — stop watching the PR thread
# (PRs use the issues subscription API)
owner_repo=$(gh pr view <number> --json repository --jq .repository.nameWithOwner)
gh api -X PUT "repos/$owner_repo/issues/<number>/subscription" \
  -f subscribed=false -f ignored=true
# Fallback if PUT is rejected:
# gh api -X DELETE "repos/$owner_repo/issues/<number>/subscription"
```

Do **not** unsubscribe after request-changes or comment-only reviews — you still
need the follow-up notifications.

```bash
# Stop servers started from this worktree (pid files, nohup jobs, known ports).
# Prefer recorded PIDs from the run; fall back to matching the worktree cwd.
for pidfile in /workspace/pr-<number>-*.pid /workspace/pr-<number>/**/*.pid; do
  [ -f "$pidfile" ] || continue
  kill "$(cat "$pidfile")" 2>/dev/null || true
  rm -f "$pidfile"
done
# Kill anything still serving from the worktree path
pkill -f "/workspace/pr-<number>" 2>/dev/null || true

# Remove the worktree (force if the branch is dirty from local certs/state)
git -C <main-clone> worktree remove --force /workspace/pr-<number> \
  || rm -rf /workspace/pr-<number>
```

If posting failed or was skipped (user said no / edit), leave servers and the
worktree running so the review can continue. Do not clean up on draft-only
stops.

## Hard rules

- **Draft only.** No writes to GitHub without an explicit yes from the user in
  this conversation. A yes in an earlier review does not carry over.
- **Decline deep-review's own submit prompt** with "no". This skill owns the
  submit step.
- **Browser checks come from the PR body**, not from a generic checklist.
  Every claimed behavior gets a PASS, FAIL, or UNTESTED. A claimed feature
  missing from browser-validate (or UNTESTED without a hard skip reason) is
  a **Blocking** item. A regression or FAIL found in browser-validate that
  this PR introduced or worsened is also **Blocking**.
- **Resolve disagreements** between code findings and browser results before
  drafting. Do not ship both sides.
- **Name the SHA** in every artifact. Reviews of a moving branch are useless
  without it.
- **Nothing product-specific lives here.** Hostnames, ports, env names, and
  review rules come from the repo and its `deep-review` skill.
- **Clean up after submit.** Once the GitHub review is posted successfully,
  stop servers started for this PR and delete the worktree. Keep the markdown
  reports and screenshots. If the posted review was an **Approve**, also
  unsubscribe from that PR's notifications (`gh api` issues subscription
  `subscribed=false` / `ignored=true`). Do not unsubscribe after
  request-changes or comment-only.
