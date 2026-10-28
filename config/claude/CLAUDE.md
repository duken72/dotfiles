# Global instructions

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Coding](#coding)
  * [Default coding style](#default-coding-style)
  * [Scope of changes](#scope-of-changes)
  * [Renaming and restructuring](#renaming-and-restructuring)
* [Documentation and answers](#documentation-and-answers)
  * [Writing comments and documentation](#writing-comments-and-documentation)
  * [Suggesting documentation updates](#suggesting-documentation-updates)
  * [Learning from mistakes](#learning-from-mistakes)
  * [Long suggestion lists](#long-suggestion-lists)
  * [Citing references](#citing-references)
  * [Writing bug reports](#writing-bug-reports)
* [Git and pull requests](#git-and-pull-requests)
  * [Commits and pushes](#commits-and-pushes)
  * [Planning work on a branch](#planning-work-on-a-branch)
  * [Tracking temporary changes](#tracking-temporary-changes)
  * [Drafting PR descriptions](#drafting-pr-descriptions)
* [Context](#context)
  * [Subtasks](#subtasks)
  * [graphify](#graphify)
  * [Local project notes](#local-project-notes)

<!-- vim-markdown-toc -->

## Coding

### Default coding style

If the repo has docs or config for coding guidelines, style,
formatting or linting, use that. If the repo doesn't have that,
use my Neovim setup. Read these files for the current setup instead of assuming it:

- `~/.config/nvim` (symlink to `~/.dotfiles/config/nvim`):
  `lua/plugins/conform.lua` (formatter and arguments per filetype),
  `lua/plugins/nvim-lint.lua` (linter per filetype), `lua/vim-settings.lua`
  (indentation: 4 spaces, no tabs).
- `~/.dotfiles/config/vale/.vale.ini`: prose styles (Google, proselint,
  write-good) for `vale`, the Markdown linter.

### Scope of changes

Touch only what the request needs: don't reformat, reword or refactor adjacent
code. Mention unrelated dead code instead of deleting it: flag it in your
reply as `💀 DEAD CODE:` followed by where it is.

### Renaming and restructuring

Before renaming, moving or restructuring files or folders, check what in the
repo references them and whether the change breaks the repo's conventions
(written rules first, then what sibling folders do). If it does, warn first:
`⚠️ WARNING:` followed by what would break.

## Documentation and answers

### Writing comments and documentation

When writing or editing comments or docs, consider rephrasing so both humans
and AI agents understand them more easily.

The same applies to answers in chat. Explain a risk or a mechanism as plain
cause and effect: what happens, when, and what the user sees. Don't squeeze it
into one dense clause full of jargon. When stating a sign or direction
(positive, negative, left, right, "opposite sign"), say which quantity it
belongs to, what it's compared with, and under which condition (e.g. "for a
left turn in R"); when two signs interact, add a small worked example with
numbers. When predicting a test result, say plainly "passes" or "fails"
and the margin against its tolerance, with the numbers. Before claiming "X
already does this",
check that X really goes through the same code path. Before saying what a
check or metric counts (a validation target, a counter, a timer), read where
it accumulates and under which condition. Before saying code "rejects" or
"fails on" an input, read what the caller does with that result (an error, a
fallback, a skip). Before explaining what a config flag or value does (a
behavior change, which frame a pose is in), check where the code uses it
(grep its uses, not only where it's parsed). Before warning that a
change breaks something, check when that thing actually runs (pipeline
triggers, schedules, branch filters). Before correcting a plan with a claim
about live state (which process is PID 1, what's running, a file's value),
check it with one command first. Before saying one branch lacks another's
changes, check which side has them (`git log A..B` both ways); a file diff
alone doesn't show the direction. Before claiming a variable is "always" or
"never" something (non-negative, set, in range), check every write to it and
the edge cases between them (a target changing mid-ramp, a lagging
accumulator), not only how it's meant to be used. This holds when you
repeat a claim from your own earlier answers or notes: re-check it, or keep
its caveat ("meant to be X; briefly Y when Z").

When you move content out of an agent instructions file (`AGENTS.md`,
`CLAUDE.md`) into a doc, keep there what agents need on most tasks: the rules
they would otherwise miss and the commands they run often (build, test,
format), even if the doc repeats them. Move explanations, background and rarely
used details to the doc, and leave a pointer.

Use only older emoji (Unicode 6, e.g. 🔴 📝 ⚠️ 👉); newer ones such as
U+1F900 and up (🧹, 🧠) show as empty boxes in my terminal font.

### Suggesting documentation updates

When you find something undocumented that would help later work by humans or
AI agents (an undocumented build step, a hidden dependency, a misleading name,
docs that no longer match the code), suggest a docs update at the end of your
work: flag each one in your reply as `📝 DOC UPDATE:` followed by what you
found and which file it belongs in. Don't edit the docs unless I ask.

When two docs sections contradict each other, or a doc contradicts the code,
flag it in your reply as `🔴 ERROR:` followed by both sides of the conflict.

### Learning from mistakes

Whenever you make a mistake (I correct you, or you find you got something
wrong), update the agent instructions so it doesn't happen again. This is a
standing request, an exception to the preceding rule.

- Repo-specific (a file, convention or quirk of one repo): the repo's
  `AGENTS.md` or `CLAUDE.md`, or its notes file from
  [Local project notes](#local-project-notes).
- General (how you work anywhere): this file,
  `~/.dotfiles/config/claude/CLAUDE.md` (`~/.claude/CLAUDE.md` links to it).
- Write the rule, not the incident, in the section it belongs to. Sharpen an
  existing rule instead of adding a near-duplicate.
- Tell me in one line, as `📌 RULE UPDATE:`, which file you changed and why.

### Long suggestion lists

When a list of suggestions, open questions or to-dos is too long to read
comfortably in chat:

- Write it to `TODO.md` (or `PLAN.md` for a plan) in the repo root, one
  checkbox per item.
- Reply with one short line only, e.g. `👉 CHECK:` TODO.md (answer is too long).
  Don't summarize or repeat the file in chat; I read it.
- Whenever an item is addressed, by you or me, tick it and note the outcome.

### Citing references

- Whenever you explain something, cite the reference right after the claim,
  bullet or paragraph it supports, not at the end. Wrap each citation in
  backticks so it shows in a different color. For example:
  - The timeout defaults to 30 s `[Ref: config.yaml (line 2)].`
  - The parser skips empty lines `[Ref: parser.py (line 7), R.md (line 7)].`
- Cite only sources that existed before you touched them (other docs, existing
  code or files, git history). Citing what you wrote or changed this session
  is citing yourself; if your own work is the only source, say so (e.g. "this
  is how I wrote it") instead of a `[Ref: ...]`.
- Take line numbers only from a read of that one file (Read, `grep -n`,
  `sed -n`). Output that joins several files, such as `cat *.yml`, numbers
  its lines across all of them, so its line numbers don't match any one file.

### Writing bug reports

When I ask for a bug report, use this template. Fill in System Info from
commands (e.g. `cat /etc/os-release`, `<tool> --version`,
`git rev-parse --short HEAD`), not from memory; leave out a line you can't
check.

```markdown
## Repro Steps

Short description

1. <first step: command, input or action>
2. <next step, until the bug shows>

**Expected behavior:**

**Actual:**

## System Info

- Component:
- Branch/commit:
- OS, platform: <name and version>
- Others metadata:
```

## Git and pull requests

### Commits and pushes

- Don't commit or push unless explicitly asked; leave changes uncommitted for
  review.
- When asked, make small commits of related changes with suitable messages;
  to push, commit first, then push.
- In the same command as the commit, check that the worktree is on the target
  branch (`test "$(git branch --show-current)" = <branch>`), and push that
  branch by name. I switch branches between turns, so a branch you saw
  earlier may no longer be checked out.

### Planning work on a branch

When I start work on a branch (other than the main branch), check the repo
root for `SPEC.md` and `PLAN.md`:

- If either is missing, suggest (`💡 SUGGEST:`) that I switch to plan mode
  with effort medium and run `/agent-skills:spec` (if `SPEC.md` is missing),
  then `/agent-skills:plan`. Don't run them yourself.
- If both exist, suggest that I switch to auto mode with effort high, then
  work from them.

While working from them, keep `PLAN.md` and `TODO.md` current as each step
lands, not only at the end: tick the items, note the outcome (run, values
chosen), and update risks or decisions the work proved wrong. Put this in
every fork prompt that works on a planned task.

### Tracking temporary changes

A temporary change only supports development on a branch and must not be
merged with it: e.g. files or commits copied from an unmerged branch,
generated output such as `graphify-out/`, debug code, local config overrides,
the draft `PR_DESCRIPTION.md` (see
[Drafting PR descriptions](#drafting-pr-descriptions)). `SPEC.md`, `PLAN.md`
and `TODO.md` from the spec and plan skills (`/agent-skills:spec`,
`/agent-skills:plan`) are always temporary: list them without asking.
Changes pulled from another branch usually are, so when I ask you to pull
some, ask whether to list them in `TEMPORARY_CHANGES.md` (as `⏳ TEMPORARY:`
followed by the files or commits).

List them in `TEMPORARY_CHANGES.md` in the repo root:

- Create it with the first temporary change. It's tracked and pushed with the
  branch (I use several machines), and is itself temporary, so list it too.
- Per entry: the files or commits and why they're temporary. Every temporary
  change goes before the pull request, so don't write a removal time per
  entry.
- Update it whenever you add or remove one, or I tell you something is
  temporary.
- Keep temporary changes in their own commits, apart from the real work, so
  they drop cleanly.

When I ask you to draft a PR description, review a PR or branch, or clean up a
branch for a PR, read the file and suggest removing its entries, the file
included, as `⏳ TEMPORARY:` followed by the entries. Only suggest; don't
remove anything unless I ask.

### Drafting PR descriptions

Pick the template first:

- The repo's own template always wins. Look for
  `.azuredevops/pull_request_template.{md,txt}`,
  `.github/pull_request_template.md`, `docs/pull_request_template.md`, or a
  `pull_request_template/` folder in `.azuredevops/` or `.github/`.
- Only if the repo has none, use `~/.claude/pr-template.md`.
- Fill in the template's sections and remove its instruction text (e.g.
  `[DELETE]`, `[CHANGE]` markers).
- Keep it at 4000 characters or fewer (the Azure DevOps limit); check with
  `wc -m` before you finish.
- No work item link or title line; the PR already links the work item.

Review the changes first, so the description matches the final code:

- If I ask for a PR description and no review has run yet, remind me
  (`🔔 REMINDER:`) to run `/ponytail-review` or a review skill (e.g.
  `/code-review`). Only remind; don't run it unless I ask.
- At the end of any review skill (`ponytail-review`, `code-review`, `review`
  or similar), ask (`❓ ASK:`) whether to create `PR_DESCRIPTION.md`, or, if
  it exists, whether to check it against the final code. Ask even if nothing
  needed fixing; if there were fixes, ask after they're applied. Don't write
  it unless I say yes.

Keep the draft in `PR_DESCRIPTION.md` in the repo root:

- It's a temporary change: tracked and pushed, listed in
  `TEMPORARY_CHANGES.md`, in its own commits.
- While it exists, re-check it after every commit or push in the session
  (changed files, test results, testing steps, character count) and update
  it without asking. Commit it separately if I asked for the commit or push;
  otherwise leave it uncommitted and tell me (`📄 PR DESC:` followed by what
  changed).
- If I share the description that's already posted, tell me where it differs
  from the file. Don't overwrite either without asking.

When the draft is in a file, reply with one line that links to it, e.g.
"PR description drafted: `PR_DESCRIPTION.md`". Don't paste, summarize or
explain its content in chat; I read the file. The same goes for any file you
draft for me to read.

## Context

### Subtasks

Keep the main conversation for talking with me; hand the work to subtasks
(forks, `Agent` with `subagent_type: "fork"`) whenever possible, so tool
output doesn't fill the main context. This is a standing request to spawn
them, and it overrides any default against spawning agents unasked. Before
the first tool call of each task, check the list below; "it's only a few
commands" is not a reason to stay in the main conversation.

- Fork by default, without asking:
  - long runs: builds, unit tests, `run_ci.py`, docker;
  - broad searches and reading where only the conclusion matters;
  - checks and reviews: lint, docs check, self-review, PR checklist items;
  - small mechanical edits, e.g. a PR description line, commit and push.
- Keep in the main conversation:
  - answers to my questions (explanations with refs);
  - decisions and design discussion with me. Writing them down in
    `SPEC.md`, `PLAN.md` or `TEMPORARY_CHANGES.md` can go to a fork, since
    forks read those files.
- Independent items (e.g. a checklist): one fork per item, in parallel. Give
  each a clear file scope so forks don't edit the same files, and say which
  fork alone may build. An item blocked by another may still get its fork,
  told to wait until the blocker is done.
- Forks follow the same rules as the main session: commit or push only when
  my request asked for it.
- After spawning a fork, write nothing; the tool call already shows it started.
  Don't spawn another agent to wait for it; its result arrives on its own.
- When a fork must wait for another run to end, have it wait on that task's
  completion or on a pattern that can't match the wait loop itself
  (`pgrep -f run_ci.py` inside a shell loop finds the loop's own command
  line and waits forever). Before relaying "running" or "started" from a
  fork's interim note, check it with one command (`docker ps`, `pgrep`).
- When a fork reports, relay only the result, in one or two short lines (e.g.
  `Pushed 5709358 to main.`). Add more only when I need it: an answer, a
  failure, a decision for me. Don't narrate what the fork did.
- Verify a fork's claim with a command only when it's doubtful or matters
  beyond the task (a test pass, a fix); skip it for routine work such as a
  commit or push the fork reports with a hash.
- A research fork's findings (what a commit changed, counts, "reverted N
  times") are claims, not facts: spot-check the ones my answer rests on with
  `git show` or one command, or say they're unverified.

### graphify

When the user types `/graphify`, invoke the graphify skill
(`~/.claude/skills/graphify/SKILL.md`) first. It turns any input (code, docs,
papers, images) into a knowledge graph.

When a repo has `graphify-out/graph.json`:

- For a codebase question, run `graphify query "<question>"` before your first
  grep, search or source read, and put this rule in every code-exploring
  subagent prompt. Read raw files only for lines the graph or an earlier read
  already located.
- Use `graphify path "<A>" "<B>"` for relationships and
  `graphify explain "<concept>"` for concepts; their scoped subgraphs are
  usually far smaller than `GRAPH_REPORT.md` or grep output.
- Use `graphify-out/wiki/index.md`, if present, for broad navigation instead of
  raw source.
- Read `graphify-out/GRAPH_REPORT.md` only for a broad architecture review or
  when query, path and explain fall short.
- A committed `graph.json` is rewritten whole on every build, so a large PR
  diff to it is expected. Don't flag it as churn or suggest skipping the
  rebuild or its hooks.

### Local project notes

Kept out of the dotfiles repo; the file may not exist on every machine.

Read the notes at the start of every conversation, before the first other
step, not only when a task seems to need them. Also read every
file a notes file says to read "before any work", such as a branch list.

@~/.claude/local.md
