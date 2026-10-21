---
name: create-pr
description: Open a GitHub pull request for the current feature branch. Reads the commits and diff against the base branch to work out what changed, writes a short plain-language description a reviewer can take in quickly, captures browser screenshots of the affected UI with playwright-cli, and creates the PR with gh, attaching the screenshots via --attach. Use when asked to "create a PR", "open a pull request", or "put this up for review".
---

# Create a pull request

Create a PR for the current branch with `gh`, describing the change in plain
language a reviewer can take in quickly, and attaching screenshots of the UI
that changed.

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

The reader is a reviewer who knows the codebase but has not seen this branch.
After one read, they should be able to say what changed, why, and where to look
closely. Write for that person, in plain language.

**How to write it**

- Write the way you would explain the change to a teammate sitting next to you:
  short sentences, everyday words, active voice.
- Start with what changes for the user, or for the code that depends on this,
  and why. Bring in implementation details only where the reviewer needs them
  to judge the change.
- Say it once. Don't restate the diff, the commit messages, or the list of
  changed files: the reviewer has all three a click away.
- Link the Jira ticket. Name files, components, and functions in backticks when
  you point the reviewer at them.
- Spell out an abbreviation the first time you use it. Avoid jargon ("spike",
  "plumbing", "wire up", "cache buster") and sales words ("robust", "seamless",
  "comprehensive").
- State facts directly. Don't hedge, and don't oversell.

**What to include**, in this order, skipping anything that doesn't apply:

1. What changed and why, in one or two sentences.
2. What a user, or another part of the code, will notice working differently.
3. What deserves a careful look: the risky or non-obvious part, a decision and
   the alternative you turned down, a known limitation, or a follow-up ticket.
4. How to read a large change, such as "each ticket is its own commit" or
   "start with `use-plan-limits.ts`".

**How long**

Match the size of the change. A small fix is two or three sentences. A branch
that covers several tickets gets one short paragraph per ticket, each starting
with its linked ticket key in bold. A reviewer should be able to read the whole
description in about two minutes. If it runs longer, cut the detail the diff
already shows.

Too technical, and the point gets lost:

> Refactors `PlanSelectorModal` into an inline `PlanSelector` with controlled
> expanded state, and moves limit fetching into a new `usePlanLimits` hook.

Plain and useful:

> Choosing a plan on the billing page no longer opens a modal. The plan
> selector now sits on the page itself, and opening a plan shows its limits
> before you pick it. Limits load when a plan is opened instead of when the
> page loads, so the page appears sooner. `usePlanLimits` is new and worth a
> careful look, because the checkout page will use it next.

**Screenshots**

Reference each screenshot where it belongs, inside a collapsed `<details>`
block. The `<summary>` is a short description of the screenshot, five words at
most. Inside the block, reference the image with meaningful alt text. `gh`
rewrites the local path to the uploaded asset:

```markdown
The billing page now shows the plan selector inline instead of behind a modal.

<details>
<summary>Inline plan selector</summary>

![Billing page with the new inline plan selector](./billing-page-new-plan-selector.png)

</details>

Opening a plan shows its limits before you commit to it.

<details>
<summary>Plan limits expanded</summary>

![Plan selector expanded showing limits](./plan-selector-open.png)

</details>
```

Keep the blank line after `</summary>` and before `</details>`. GitHub does not
render Markdown inside an HTML block unless a blank line separates them, so
without it the image shows as raw text. Give every attached screenshot a block
like this: `gh` appends an image the body does not reference to the end of the
description, outside any `<details>`.

Hard rules for the body:

- **Never add a testing or verification section.** No "How to test", "Testing
  steps", "QA", "Verification", checklists of things to click.
- **Never mention that Claude, an AI, or an assistant wrote or helped with the
  PR.** No "Created with Claude", no "Generated with Claude Code", no
  Co-Authored-By or attribution footer of any kind in the PR body.
- No headings for the sake of structure. If the change is one paragraph, the
  body is one paragraph. For several tickets, start each paragraph with the
  bold ticket key instead of a heading.
- No tables and no nested bullet lists. Prose is faster for a reviewer to read.
- No bullet lists that just re-list the commits or the changed files.
- No filler like "This PR", "In this pull request", "Summary of changes".

Before creating the PR, reread the body as the reviewer would. Rewrite any
sentence that takes a second read, and delete any sentence that tells the
reviewer nothing they need.

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
  --draft \
  --base "$base" \
  --title "ND-1234: Show plan selector inline on the billing page" \
  --body-file "$body" \
  --attach "$shots/billing-page-new-plan-selector.png#Billing page with the new inline plan selector" \
  --attach "$shots/plan-selector-open.png#Plan selector expanded showing limits"
```

- One `--attach` per file, up to 50. Alt text goes after `#`. When the body
  already references the file with `![alt](./name.png)`, that reference is
  rewritten in place and keeps the body's alt text; otherwise the image is
  appended at the end, outside any `<details>` block, so reference every file
  as step 5 shows.
- Run from the scratch directory or use paths that match the body references.
- Always pass `--draft`. Every PR this skill creates is a draft, regardless
  of whether the user asked for one.
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
