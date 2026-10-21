---
name: browser-validate
description: Confirm a change works by driving the real app in a browser with playwright-cli — reach the UI that changed, read the live DOM to prove the new behavior, screenshot it, and clean up afterwards. Use when asked to "validate in the browser", "browser validate", "check this in the browser", "verify it in the app", "see it working", or otherwise to confirm a change outside the test suite.
---

# Validate a change in the browser

A passing test suite proves the code does what the test says. Browser
validation proves the app does what the person asked for. They fail
differently, so do this whenever a browser can render the thing that changed.

## Always use playwright-cli

`playwright-cli` is the tool for this. Load the **playwright-cli** skill before
the first command: invoke it by name if this session lists it, otherwise read
its `SKILL.md` directly — on this machine it is at
`~/Work/.claude/skills/playwright-cli/SKILL.md`, with deeper notes beside it in
`references/` (storage state, request mocking, tracing, video, attaching
screenshots to a PR).

Do not write a throwaway Playwright spec, a Puppeteer script, or a custom
driver to do what `playwright-cli` already does. The one exception is a repo
whose own suite is the shortest path to a signed-in session — then borrow its
saved auth state (below) and still drive the page with `playwright-cli`.

## What counts as validated

Three things, in order. Skipping any of them means the check did not happen.

1. **A named assertion.** Before opening the browser, write down what you
   expect to see — the exact strings, numbers, or elements. "Check it looks
   right" is not an assertion and cannot fail.
2. **A value read off the live DOM.** `playwright-cli eval` returns what the
   page actually holds. Screenshots are evidence for the person reading your
   report; they are not how you decide.
3. **A screenshot you actually looked at.** Read the image back. A blank frame,
   an error boundary, or a sign-in redirect all "pass" if nobody opens the file.

## Steps

### 1. Get the app running, and trust nothing that was already up

Start the app the way the project documents. If a dev server is already
listening, check how old it is before reusing it:

```bash
lsof -nP -iTCP:<port> -sTCP:LISTEN            # is anything there?
ps -o lstart= -p <pid>                        # since when?
```

A server that has been up for hours or days can be serving a stale config or a
stale dependency cache, and it will fail in ways that look like your change
broke something. **Do not kill it** — it is the person's, and they may be using
it. Start your own on a free port instead and drive that.

### 2. Get authenticated, cheaply

Most real apps need a session. In order of preference:

- **Reuse a storage state the repo already produces.** Many repos have a
  Playwright auth setup that writes one (look for `storageState`, `*.auth`,
  `e2e/.auth/`). Run that setup once, then
  `playwright-cli state-load <path/to/state.json>`.
- **Set the session cookie directly** with `playwright-cli cookie-set` when you
  can obtain one.
- **Ask the person** how to sign in, rather than guessing at credentials.

### 3. Drive to the UI that changed

```bash
playwright-cli open
playwright-cli state-load e2e/.auth/test-user.json
playwright-cli goto https://localhost:<port>/<route>
playwright-cli find "Add account"                 # locate by visible text
playwright-cli find --regex '/option "401\(k\)"/' # or by role and name
playwright-cli click e171
```

Refs like `e171` come from the most recent snapshot. After anything that
re-renders, run `find` again rather than reusing an old ref.

### 4. Read the values, do not eyeball them

```bash
playwright-cli eval "el => el.value" e753
playwright-cli eval "() => Array.from(document.querySelectorAll('[data-slot=percent-input]')).map(i => i.value).join(' | ')"
```

Prove both directions when the change is conditional: the new state appears
**and** the old state is gone or comes back when the condition flips. A label
that swapped is only half-checked until you confirm the previous label is no
longer on the page.

### 5. Screenshot, and read it back

```bash
playwright-cli screenshot e530        # one element, usually clearer than the page
playwright-cli screenshot --hires     # when fine detail matters
```

The command prints the file it wrote. Open that file and look at it.

### 6. Clean up

- `playwright-cli close`.
- Stop only the servers **you** started; leave the person's alone.
- Delete throwaway specs, configs, screenshots, and auth files you created, and
  confirm with `git status` that the working tree is as you found it.

## Stay read-only unless asked

Validation should not mutate data. Open the form, fill it, read the labels and
the derived values — then stop. Submitting against a shared staging account
changes data other people and other pipelines depend on. If proving the change
genuinely requires a write, say so and get agreement first, and prefer a
disposable account the repo knows how to create.

## When it fails

Separate the two kinds of failure before reporting:

- **The environment is broken** — stale server, expired session, backend down,
  missing certificate. Say so plainly, say what you did about it, and finish
  the validation. Do not report the change as unverified when the obstacle was
  the machine.
- **The change is wrong** — the assertion from step 1 did not hold. Report the
  expected value, the actual value read from the DOM, and the screenshot.

## Reporting

Say what you asserted and what the page returned — the actual strings and
numbers, not "it worked". Name the route, the state you drove the UI into, and
anything you noticed in passing that was not part of the assertion.
