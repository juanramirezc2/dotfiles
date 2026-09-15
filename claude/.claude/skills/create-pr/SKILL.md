---
name: create-pr
description: Open a GitHub pull request for the current feature branch. Reads the commits and diff against the base branch to work out what changed, captures browser screenshots of the affected UI with playwright-cli, and creates the PR with gh, attaching the screenshots via --attach. Use when asked to "create a PR", "open a pull request", or "put this up for review".
---

# Create a pull request

Create a PR for the current branch with `gh`, describing the change in plain
prose and attaching screenshots of the UI that changed.

## Requirements

- `gh` **2.99.0 or newer**. The `--attach` flag on `gh pr create` was introduced
  in 2.99.0. Check with `gh --version` and stop with a clear message if older.
- `playwright-cli` on PATH (`@playwright/cli`). Only needed when the diff touches
  something a browser can render.
- The app's dev server running locally when screenshots are needed. If it is not
  running, start it the way the project documents, or ask for the URL.

## Steps

### 1. Work out the base branch and the change set

```bash
git fetch origin --quiet
base=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|origin/||')
base=${base:-main}
branch=$(git branch --show-current)

git log --reverse --format='%h %s%n%b' "origin/$base..HEAD"
git diff --stat "origin/$base...HEAD"
git diff "origin/$base...HEAD"
```

Read the commit messages first: they say what the author intended. Then read the
diff to confirm what actually changed. The PR is about the combination of the
two, not a restatement of either.

If the branch has no commits ahead of the base, stop and say so.

### 2. Find the Jira ticket

The title must start with the ticket key, e.g. `ND-1234: short description`.

Look for a key matching `[A-Z][A-Z0-9]+-[0-9]+` in this order:

1. the branch name (`feature/ND-1234-add-thing`, `ND-1234/thing`, …)
2. the commit subjects and bodies
3. the user's request

If none is found, ask the user for it before creating the PR. Do not invent one
and do not omit it.

### 3. Decide which screens to capture

From the diff, list the files that affect what a user sees: pages, routes,
components, templates, stylesheets, copy. Map each to the URL where it renders.
Look at the router or pages directory when the mapping is not obvious.

If nothing in the diff is visible in a browser (pure backend, config, tests,
tooling), skip screenshots entirely. Do not take a screenshot just to have one.

### 4. Capture screenshots with playwright-cli

Save into a scratch directory, one file per relevant view, with descriptive
filenames. The filename becomes the default alt text, and the alt text is what
reviewers read.

```bash
shots=$(mktemp -d)
playwright-cli open http://localhost:3000        # add --headed if you want to watch
playwright-cli resize 1440 900
playwright-cli goto http://localhost:3000/settings/billing
playwright-cli snapshot                          # find element refs / confirm the page loaded
playwright-cli screenshot --filename "$shots/billing-page-new-plan-selector.png"
playwright-cli click e12                         # drive to the state you need
playwright-cli screenshot e30 --filename "$shots/plan-selector-open.png"   # element only
playwright-cli close
```

Guidance:

- Capture the state that demonstrates the change, not the landing page. Open the
  modal, trigger the error, fill the form, select the tab.
- Prefer element screenshots (`screenshot <ref>`) for small component changes and
  `--full-page` for layout or page-level changes.
- If the change needs an authenticated session, use `playwright-cli state-load`
  with a saved storage state, or ask the user to log in with `--headed`.
- For responsive changes, take one desktop and one mobile shot (`open --mobile`
  or `resize 390 844`).
- Look at each screenshot before attaching it. If it shows a loading spinner,
  an error you did not intend, or the wrong route, retake it.

### 5. Write the description

Write in natural language, as one engineer explaining the change to another.
Short paragraphs. Say what changed and why. Mention anything a reviewer should
pay attention to, such as a behavior change, a migration, or a trade-off.

Reference each screenshot inline where it belongs, with meaningful alt text.
`gh` rewrites the local path to the uploaded asset:

```markdown
The billing page now shows the plan selector inline instead of behind a modal.

![Billing page with the new inline plan selector](./billing-page-new-plan-selector.png)

Opening a plan shows its limits before you commit to it.

![Plan selector expanded showing limits](./plan-selector-open.png)
```

Hard rules for the body:

- **Never add a testing or verification section.** No "How to test", "Testing
  steps", "QA", "Verification", checklists of things to click.
- **Never mention that Claude, an AI, or an assistant wrote or helped with the
  PR.** No "Created with Claude", no "Generated with Claude Code", no
  Co-Authored-By or attribution footer of any kind in the PR body.
- No headings for the sake of structure. If the change is one paragraph, the
  body is one paragraph.
- No bullet lists that just re-list the commits or the changed files.
- No filler like "This PR", "In this pull request", "Summary of changes".

Write the body to a file rather than passing it inline, so quoting is not an
issue and it is easy to review:

```bash
body="$shots/pr-body.md"
cat > "$body" <<'MD'
...
MD
```

### 6. Create the PR

```bash
gh pr create \
  --base "$base" \
  --title "ND-1234: Show plan selector inline on the billing page" \
  --body-file "$body" \
  --attach "$shots/billing-page-new-plan-selector.png#Billing page with the new inline plan selector" \
  --attach "$shots/plan-selector-open.png#Plan selector expanded showing limits"
```

- One `--attach` per file, up to 50. Alt text goes after `#`. When the body
  already references the file with `![alt](./name.png)`, that reference is
  rewritten in place and keeps the body's alt text; otherwise the image is
  appended at the end.
- Run from the scratch directory or use paths that match the body references.
- Add `--draft` only if the user asked for a draft.
- Push the branch first if it has no upstream: `git push -u origin "$branch"`.

If some attachments fail, `gh` still creates the PR and prints its URL but exits
non-zero. Report which files failed and offer to attach them with
`gh pr edit --attach`.

### 7. Report

Print the PR URL, the title, and which screenshots were attached. Nothing else.

## Title format

`<TICKET>: <short imperative description>`

- Ticket key uppercase, exactly as in Jira, followed by a colon and a space.
- Description under about 60 characters, no trailing period, no conventional
  commit prefix (`feat:`, `fix:`), no ticket key repeated.

Good: `ND-1234: Show plan selector inline on the billing page`
Bad: `feat(billing): ND-1234 inline plan selector`
Bad: `ND-1234`
