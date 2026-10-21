---
name: create-ticket
description: Create Jira tickets (stories, tasks, bugs, epics) in the user's team project the way their team files them — an intent-first description in plain language, acceptance criteria in the Acceptance Criteria field, the user's team, assigned to the user, a story placed under the right epic, and the team's active sprint. Use it whenever the user asks to create, file, open, log, or write up a Jira ticket, story, task, bug, or epic, including "make a ticket for this", "turn this into a story", "log a bug for that", or "we need a ticket before the PR", even when they don't mention any of the conventions.
---

# Create a ticket

File a Jira ticket that a teammate can pick up and understand without asking what it is for. Every ticket this skill creates carries the same fields (team, assignee, sprint, epic, acceptance criteria) so the team's board and reports stay accurate, and a description that explains the intent of the work, not just its steps.

## Team defaults

The site, project, team, and field ids belong to the user's workplace, so they are kept out of this skill, in `~/.config/agent-skills/work.md`. Read it first. It names:

- The Jira site (pass the hostname as the cloud id) and the project key.
- The **assignee**'s account id. Assign every ticket to the user unless they name someone else.
- The **Team** field id and the team's id. Pass the id string. The file lists any short names the user has for the team.
- The **Acceptance criteria** field id.
- The **Sprint** field id, the team's board id, and how its sprints are named.
- The default **priority**. Use it unless the user names another.
- The initiative the team's epics sit under, and hints for matching work to epics.

If the file is missing, look the values up and offer to save them there: `atlassianUserInfo` gives the user's account id, `getAccessibleAtlassianResources` lists the sites, and `getJiraIssue` on a recent ticket of the team's with `expand: "names"` lists every field id and its label. Ask the user for the project key and the team name rather than guessing. If a field id or value is rejected later, look it up again the same way rather than dropping the field.

Below, `<project>`, `<team id>`, and `<board id>` stand for those values, and the Team, Sprint, and Acceptance criteria fields for their field ids.

## Tools

In Claude Code, use the Atlassian connector's tools: `searchJiraIssuesUsingJql`, `createJiraIssue`, `editJiraIssue`, and `getJiraIssue` (the client adds a prefix such as `mcp__claude_ai_Atlassian__`; load them first if they are deferred). Another agent uses its own Atlassian connector, or the Jira REST API v3 (`POST /rest/api/3/issue`, `PUT /rest/api/3/issue/{key}`, `GET /rest/api/3/search/jql`). If none of these is available, say so and stop. Writing out a ticket that looks created, when nothing was created, sends the user to the board for something that isn't there.

## Steps

### 1. Understand the work

From the request and the conversation so far, work out who is affected, what is wrong or missing today, what will change, and how anyone will know it is done. When the conversation already covers the work (a feature just built, a bug just found, a doc just read), draw on it; the user shouldn't have to repeat it.

When the request points at a spec, a design doc, another ticket, or existing code, read it. Those are where the open questions come from: a figure two screens compute differently, a state nobody has designed, an endpoint that doesn't exist yet.

If the purpose or the finish line is missing and can't be inferred, ask one short question. Don't invent requirements to fill a gap. A question nobody can answer yet goes in the ticket as an open question. So does a part the user asked for that is blocked by something missing, such as an endpoint: keep it in scope, name what blocks it under the open questions, and mention it in your report, so the decision to drop or wait for it stays with the team.

### 2. Pick the type

- **Story:** a change a user will see or use.
- **Task:** work users don't see directly, such as tooling, a refactor, a follow-up, or an investigation.
- **Bug:** something works differently from how it should.
- **Epic:** only when the user asks for one, or when a story has no epic to belong to and the user agrees to a new one.

### 3. Check for a duplicate

Search before creating: `project = <project> AND summary ~ "<two or three key words>" AND statusCategory != Done ORDER BY updated DESC`. Once you know the epic (next step), also list its children (`parent = <epic key>`), which catches a duplicate whose title uses other words. If an open ticket already covers the work, show it and ask whether to use it instead.

Pass a short `fields` list (for example `["summary", "status", "parent"]`) on every search. Without one, a broad query returns every field of every issue, which is far more than you need to read.

### 4. Find the epic (stories)

A story always belongs to an epic; it is how the team groups and tracks work. Search the team's open epics:

```
project = <project> AND issuetype = Epic AND statusCategory != Done
AND "Team[Team]" = <team id> ORDER BY updated DESC
```

Ask for `summary`, `description`, and `parent`, and add `AND text ~ "<topic>"` when the list is long. Some epics have no team set, so when nothing matches, run the search again without the team filter. Match on the product area the story changes, using the hints in the defaults file. Look at where recent stories on the same screen were filed if the epic names are vague.

- One clear match: use it, and name it in your report so the user can correct it.
- Several plausible matches, or none: ask, listing the two or three best candidates with their links, and offer to create a new epic.

A task or bug takes an epic when an obvious one exists. Otherwise it goes without.

### 5. Find the active sprint (everything except epics)

Look it up every time, because sprints roll over and a sprint can stay active past its end date until the team closes it:

```
project = <project> AND sprint in openSprints()
AND "Team[Team]" = <team id> ORDER BY updated DESC
```

Request only the Sprint field; the connector's smallest `maxResults` is 50, but the first result is enough. Each issue lists its sprints; use the entry with `"state": "active"` and the team's `<board id>` as its `boardId`, and take its numeric `id`. If that sprint's end date has passed, use it anyway, since it is still the one the board shows, and mention it in your report so the team can close it. If no sprint is active, create the ticket without one and say so. Epics span sprints, so they never get one.

### 6. Write the summary, description, and acceptance criteria

See **Writing the ticket** below.

### 7. Create it

Call `createJiraIssue` with the project, the type, the summary, the description as Markdown, `parent` (the epic key for a story; the connector describes `parent` as being for subtasks, but it is also how a story joins its epic), `assignee_account_id`, and in `additional_fields`: `priority` (for example `{"name": "P2"}`), the Team field (the team id), and the Sprint field (the sprint id as a number).

Then set the acceptance criteria with `editJiraIssue`, `contentFormat: "adf"`, and an ADF document in the Acceptance criteria field. The field rejects Markdown and plain text when the issue is created, so it is set afterwards, as ADF.

A create with a long description can time out and still create the issue. Before retrying, search for the summary so you don't file it twice.

### 8. Check it

Read the ticket back (`summary`, `assignee`, `parent`, and the Team, Sprint, and Acceptance criteria fields) and fix anything that didn't stick. `getJiraIssue` returns the acceptance criteria as Markdown even though they were written as ADF; that's expected.

### 9. Report

Give the key with its link, the type, the epic, and the sprint, plus one line on what the ticket is for. If you created an epic too, list it first. Then name anything the user should act on: an epic you chose among close candidates, a sprint past its end date, or a requested part that is blocked.

## Writing the ticket

Tickets are read by engineers, product managers, designers, and QA. They know the product but haven't seen this conversation, the code, or the doc you read. Write for them.

When the user points at another ticket as the pattern to follow, take the scope and structure of the work from it, and still write this ticket in the format below; older tickets predate these conventions.

### Summary

Name the product area, then what changes: `Notifications: Show unread alerts in the top-nav bell`, `Billing: Show plan limits before checkout`. Keep it under about 90 characters, with no trailing period and no ticket-type prefix.

### Description

Open with the intent: why this work exists, meaning the problem a user has today or the outcome the team wants, in two or three plain sentences. Someone who reads only that opening should know why the ticket matters.

Then say what changes: what a user will see or be able to do, or what will work differently. After that, add what is out of scope, the open questions, and links to the design, the spec, related tickets, and pull requests.

- Write the way you'd explain it to a teammate: full sentences, everyday words, active voice.
- A short ticket is a few paragraphs. A long one can use a few headings (for example Why, What changes, Out of scope, Open questions). Don't add a heading for its own sake.
- Spell out an abbreviation the first time it appears, and link anything a reader might need to look up rather than pasting it in.
- Avoid jargon such as "spike", "plumbing", or "wire up", and sales words such as "robust" or "seamless".
- Leave out file paths, function names, and implementation steps unless they record a decision the team has already made or a constraint the implementer must know. Put those briefly at the end.
- Don't restate the acceptance criteria.

Too mechanical, with the intent missing:

> Add `usePlanLimits` hook, render PlanSelector inline on /settings/billing, move limits to constants.

Intent first, in plain language:

> People choosing a plan can't see what each plan includes until after they've paid, so some pick the wrong one and have to contact support to switch. Showing each plan's limits on the billing page, before checkout, lets them choose the right plan the first time. The limits come from the same place the checkout page reads them, so both pages always agree.

### Acceptance criteria

List outcomes someone can check without reading code: what a user sees or can do, including empty, loading, and error states and any edge case the work has to handle. Put one behavior in each item, stated specifically and in the present tense. For example, write "The badge is hidden when there are no unread alerts" rather than "The badge works correctly". Leave out implementation details and statements like "tests pass". With more than about seven items, group them under short headings.

The field takes an ADF document: a bullet list of paragraphs, with level-3 headings between groups when grouped.

```json
{
  "type": "doc",
  "version": 1,
  "content": [
    { "type": "heading", "attrs": { "level": 3 }, "content": [{ "type": "text", "text": "Badge" }] },
    {
      "type": "bulletList",
      "content": [
        {
          "type": "listItem",
          "content": [
            {
              "type": "paragraph",
              "content": [{ "type": "text", "text": "The badge is hidden when there are no unread alerts." }]
            }
          ]
        }
      ]
    }
  ]
}
```

## Epics

An epic's summary names the area of work (`Billing Self-Serve`). Its description says what the group of stories delivers and why, and links to the spec. Set its `parent` to the initiative its sibling epics sit under, which the defaults file names. Give it the same team, assignee, and priority as any ticket, but no sprint. Acceptance criteria are optional for an epic and usually left empty.
