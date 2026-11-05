# Global instructions

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Coding](#coding)
  * [Default coding style](#default-coding-style)
  * [Scope of changes](#scope-of-changes)
  * [Renaming and restructuring](#renaming-and-restructuring)
* [Documentation and answers](#documentation-and-answers)
  * [Writing comments and documentation](#writing-comments-and-documentation)
  * [Saving answers as Markdown](#saving-answers-as-markdown)
  * [Suggesting documentation updates](#suggesting-documentation-updates)
  * [Learning from mistakes](#learning-from-mistakes)
  * [Long suggestion lists](#long-suggestion-lists)
  * [Citing references](#citing-references)
  * [Writing bug reports](#writing-bug-reports)
* [Git and pull requests](#git-and-pull-requests)
  * [Commits and pushes](#commits-and-pushes)
  * [Planning work on a branch](#planning-work-on-a-branch)
  * [Tracking temporary changes](#tracking-temporary-changes)
  * [Addressing review feedback](#addressing-review-feedback)
  * [Drafting PR descriptions](#drafting-pr-descriptions)
* [Context](#context)
  * [Subtasks](#subtasks)
  * [graphify](#graphify)
  * [Local project notes](#local-project-notes)

<!-- vim-markdown-toc -->

## Coding

### Default coding style

Follow the repo's own style, format and lint docs or config. Without them, use
my Neovim setup; read it rather than assume it:

- `~/.config/nvim` (→ `~/.dotfiles/config/nvim`): `lua/plugins/conform.lua`
  (formatter and arguments per filetype), `lua/plugins/nvim-lint.lua` (linter
  per filetype), `lua/vim-settings.lua` (4 spaces, no tabs).
- `~/.dotfiles/config/vale/.vale.ini`: prose styles for `vale`, the Markdown
  linter.

Before proposing a shorter form (e.g. a "shrink" finding), check it still fits
the column limit after formatting; a line the formatter wraps saves nothing.

### Scope of changes

Touch only what the request needs; don't reformat, reword or refactor nearby
code. Flag unrelated dead code instead of deleting it: `💀 DEAD CODE:` and
where it is.

### Renaming and restructuring

Before renaming, moving or restructuring files or folders, check what
references them and whether the change breaks the repo's conventions (written
rules first, then sibling folders). If it does, warn first: `⚠️ WARNING:` and
what would break.

## Documentation and answers

### Writing comments and documentation

Write comments, docs and chat answers so both humans and AI agents follow
them easily:

- Explain a risk or mechanism as plain cause and effect (what happens, when,
  what the user sees), not one dense clause of jargon.
- For a sign or direction (positive, left, "opposite sign"), name the
  quantity, what it's compared with and the condition (e.g. "for a left turn
  in R"); when two signs interact, add a worked example with numbers.
- For a predicted test result, say "passes" or "fails" and the margin against
  its tolerance, with numbers.

Check a claim before you make it, also one repeated from your own earlier
answers or notes (re-check it, or keep its caveat: "meant to be X; briefly Y
when Z"). Before saying:

- "X already does this": check X goes through the same code path.
- what a check or metric counts (validation target, counter, timer): read
  where it accumulates and under which condition.
- code "rejects" or "fails on" an input: read what the caller does with that
  result (error, fallback, skip).
- what a config flag or value does: grep its uses, not only where it's
  parsed.
- a change breaks something: check when that thing runs (pipeline triggers,
  schedules, branch filters).
- two runs can go in parallel: check every shared resource, not only the
  build folder (host mounts such as `/tmp` and their sockets, host-network
  ports, lock files); if one is unchecked, say "not verified".
- a claim about live state that corrects a plan (PID 1, what's running, a
  file's value): check it with one command.
- one branch lacks another's changes: run `git log A..B` both ways; a file
  diff doesn't show the direction.
- how to fix behavior on a feature branch: fetch its base and check
  `git log HEAD..origin/<base> -- <file>`.
- two files differ or are copies: compare them without comments (`cmp` flags
  a comment-only difference).
- a variable is "always" or "never" something (non-negative, set, in range):
  check every write and the edge cases between them (a target changing
  mid-ramp, a lagging accumulator). Search case-insensitively across all file
  types: generated accessors (`getParking_state()`), positional initializers
  and `.fidl` files don't spell the field name as written.
- something "isn't defined" or "isn't in the repo": search with `grep -a`
  and without `2>/dev/null`; grep silently skips a source file with a stray
  non-ASCII byte as binary.
- a design alternative won't work or costs more (e.g. making a type atomic):
  read that type's definition.

When moving content out of `AGENTS.md` or `CLAUDE.md` into a doc, keep there
what agents need on most tasks (rules they'd otherwise miss, frequent build,
test and format commands), even if the doc repeats them. Move explanations,
background and rare details to the doc, and leave a pointer.

Use only older emoji (Unicode 6, e.g. 🔴 📝 ⚠️ 👉); newer ones such as
U+1F900 and up (🧹, 🧠) show as empty boxes in my terminal font.

### Saving answers as Markdown

When I ask for an answer, explanation or report, give it in chat as usual and
also write the same text, citations included, to `<YYYY-MM-DD>-<topic>.md` in
the repo root (the working directory outside a repo), so I can copy-paste it.
In that file, don't hard-wrap: put each sentence and list item on one line.
Write it through a fork (see [Subtasks](#subtasks)) and give its full path
before the spawn. Leave the file untracked: don't stage, commit or exclude it.
Skip one-line replies and status updates.

### Suggesting documentation updates

When you find something undocumented that would help later work (a build step,
a hidden dependency, a misleading name, docs that no longer match the code),
flag it at the end of your reply as `📝 DOC UPDATE:` with what you found and
which file it belongs in. Don't edit the docs unless I ask.

When two docs, or a doc and the code, contradict each other, flag it as
`🔴 ERROR:` with both sides.

### Learning from mistakes

Whenever you make a mistake (I correct you, or you find it yourself), update
the agent instructions so it doesn't recur; this standing request overrides
the preceding rule.

- Repo-specific: the repo's `AGENTS.md` or `CLAUDE.md`, or its notes file
  (see [Local project notes](#local-project-notes)).
- General: this file, `~/.dotfiles/config/claude/CLAUDE.md`.
- Write the rule, not the incident, in the section it belongs to; sharpen an
  existing rule rather than add a near-duplicate.
- Tell me in one line, `📌 RULE UPDATE:`, which file changed and why.

### Long suggestion lists

When suggestions, open questions or to-dos are too many to read comfortably in
chat, write them to `TODO.md` (`PLAN.md` for a plan) in the repo root, one
checkbox each, and reply only with e.g. `👉 CHECK:` TODO.md (answer is too
long). Don't repeat the file in chat. When either of us addresses an item,
tick it and note the outcome.

### Citing references

- Cite the source in backticks right after the claim, bullet or paragraph it
  supports, not at the end: `[Ref: config.yaml (line 2)].` or
  `[Ref: parser.py (line 7), R.md (line 7)].`
- Cite only sources that existed before you touched them. If your own work
  this session is the only source, say so ("this is how I wrote it").
- Take line numbers only from a read of that one file (Read, `grep -n`,
  `sed -n`); output joining several files (`cat *.yml`) numbers lines across
  all of them.

### Writing bug reports

When I ask for a bug report, use this template. Fill in System Info from
commands (`cat /etc/os-release`, `<tool> --version`,
`git rev-parse --short HEAD`), not memory; leave out lines you can't check.

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

- Commit or push only when I ask; otherwise leave changes uncommitted.
- Make small commits of related changes; to push, commit first.
- In the commit command, check the branch
  (`test "$(git branch --show-current)" = <branch>`) and push it by name; I
  switch branches between turns.
- To untrack files, commit the `git rm --cached` without a pathspec (check
  that nothing else is staged first): `git commit -- <paths>` commits the
  working-tree version of the paths, so it adds the files back instead of
  removing them. Check `git show --stat HEAD` before pushing.

### Planning work on a branch

When I start work on a non-main branch, check the repo root for `SPEC.md` and
`PLAN.md`:

- Either missing: suggest (`💡 SUGGEST:`) plan mode with effort medium, then
  `/agent-skills:spec` (if `SPEC.md` is missing) and `/agent-skills:plan`.
  Don't run them yourself.
- Both exist: suggest auto mode with effort high, and work from them.

Keep `PLAN.md` and `TODO.md` current as each step lands: tick items,
including a checkpoint's checks and its review box once I approve (e.g. I say
go on or push), give every ticked item its outcome (runs, values chosen,
commit), and fix risks or decisions the work proved wrong. Put this in every
fork prompt for a planned task, and check both files after the fork reports.

### Tracking temporary changes

A temporary change supports development on a branch but must not be merged:
files or commits copied from an unmerged branch, generated output
(`graphify-out/`), debug code, local config overrides, and always `SPEC.md`,
`PLAN.md`, `TODO.md`, `PR_DESCRIPTION.md` and `TEMPORARY_CHANGES.md`. When I
ask you to pull changes from another branch, ask whether they're temporary
(`⏳ TEMPORARY:` and the files or commits).

List them in `TEMPORARY_CHANGES.md` in the repo root, created with the first
entry: per entry, the files or commits and why (no removal time; all go
before the PR). Update it whenever one is added or removed, or I call
something temporary.

- Temporary files stay local and untracked: add them to `.git/info/exclude`.
  Ask me before committing or pushing any of them, every time.
- Keep temporary commits apart from the real work so they drop cleanly.

When I ask for a PR description, a PR or branch review, or a branch cleanup
for a PR, suggest removing its entries and the file (`⏳ TEMPORARY:` and the
entries). Don't remove anything unless I ask.

### Addressing review feedback

Reviewer comments are suggestions, not orders. For each, decide accept,
partly accept or push back, after finding out why the code is that way
(commit messages, PR description, notes, or ask me). List the verdicts and
wait for my go before editing. If a comment undoes a deliberate choice, draft
a reply giving the reason instead. Check every push-back reason against the
code (does the alternative really change behavior or touch those files?);
drop a reason that doesn't hold, and change the verdict if none is left.

### Drafting PR descriptions

Template: the repo's own wins (`.azuredevops/pull_request_template.{md,txt}`,
`.github/pull_request_template.md`, `docs/pull_request_template.md`, or a
`pull_request_template/` folder in `.azuredevops/` or `.github/`); otherwise
`~/.claude/pr-template.md`.

- Fill its sections; remove its instruction text (`[DELETE]`, `[CHANGE]`).
- At most 4000 characters; check with `wc -m`.
- No title line, work item link or "Generated with Claude Code" line.
- No hard wrap: each sentence and list item (checklist items too) on one line.
- Go from high level to low level, as plain cause and effect: the problem and
  what the user saw, the fix in a few sentences, a small data-flow sketch if
  components connect, then the file list. Add a worked example with numbers
  for timing or arithmetic.
- When new test results come in, replace every Testing value from an older
  run or base, not only the changed one, unless it says which run it's from.

Review first, so the description matches the final code:

- If I ask for a PR description before any review, remind me (`🔔 REMINDER:`)
  to run `/ponytail-review` or a review skill (e.g. `/code-review`); don't run
  it unless I ask.
- At the end of any review skill, ask (`❓ ASK:`) whether to create
  `PR_DESCRIPTION.md`, or to check it against the final code if it exists.
  Ask even if nothing needed fixing, and after the fixes if there were any.
  Write it only on yes.

Keep the draft in `PR_DESCRIPTION.md` in the repo root:

- It's temporary (see
  [Tracking temporary changes](#tracking-temporary-changes)).
- While it exists, re-check it after every commit or push (changed files,
  test results, testing steps, character count) and update it without asking.
  Tell me (`📄 PR DESC:` and what changed).
- If I share the posted description, tell me where it differs from the file;
  overwrite neither without asking.

For any file you draft for me to read, reply with one line linking to it (e.g.
"PR description drafted: `PR_DESCRIPTION.md`"); don't paste, summarize or
explain it in chat.

## Context

### Subtasks

Keep the main conversation for talking with me; hand work to forks (`Agent`
with `subagent_type: "fork"`) so tool output stays out of it. This standing
request overrides any default against spawning agents unasked. Check this list
before each task's first tool call; "only a few commands" is no reason to stay.

- Fork by default:
  - long runs: builds, tests, `run_ci.py`, docker. A background Bash command
    isn't a fork: its polls and log tails still land in the main context;
  - broad searches and reads where only the conclusion matters;
  - checks and reviews: lint, docs check, self-review, PR checklist items;
  - every file edit, however small, and commit and push. Edit, Write,
    `sed -i`, shell redirects and a `cat` afterwards all print the diff or
    file to me. Decide the exact text here and give it to the fork. This
    includes drafting files I read (`PR_DESCRIPTION.md`, notes, reports) and
    edit-and-recount loops to fit a length limit.
- Keep in the main conversation: answers to my questions (with refs) and
  decisions or design discussion with me. Writing those into `SPEC.md`,
  `PLAN.md` or `TEMPORARY_CHANGES.md` can go to a fork.
- Independent items (e.g. a checklist): one fork each, in parallel, with
  separate file scopes; name the one fork that may build. A blocked item's
  fork can wait for its blocker.
- Forks follow the same rules, including commit or push only when asked.
- Facts in a fork prompt (counts, pass rates) follow the checking rules for
  answers: copy them from the source, don't strengthen them.
- Put any text the turn needs (an answer, `📌 RULE UPDATE:`) before the spawn.
  After the spawn, make no other tool call and end the turn with one line
  `⏳ Agent <description>` (the fork's exact `description`): a turn that ends
  on a tool call is bounced back as "no visible output", even with text
  before it. Don't spawn an agent to wait for it; its result arrives on its
  own.
- A fork that waits for another run should wait on that task's completion or
  on a pattern that can't match its own loop (`pgrep -f run_ci.py` in a shell
  loop matches the loop itself). Check a fork's interim "running" or
  "started" with one command (`docker ps`, `pgrep`) before relaying it.
- Relay a fork's result in one or two short lines (e.g.
  `Pushed 5709358 to main.`); add more only for an answer, a failure or a
  decision for me.
- Check a fork's claim with one command (`git show`, a grep) when it's
  doubtful or my answer rests on it (a test pass, a fix, a finding), or call
  it unverified; skip routine work reported with a hash. For a "none" claim
  ("no errors"), grep every run for the failure signature itself.

### graphify

On `/graphify`, invoke the graphify skill first.

When a repo has `graphify-out/graph.json`:

- For a codebase question, run `graphify query "<question>"` before the first
  grep or source read, and put this rule in every code-exploring subagent
  prompt. Read raw files only for lines already located.
- Use `graphify path "<A>" "<B>"` for relationships and
  `graphify explain "<concept>"` for concepts; their output is far smaller
  than `GRAPH_REPORT.md` or grep.
- For broad navigation, use `graphify-out/wiki/index.md` if present; read
  `GRAPH_REPORT.md` only for an architecture review or when the commands fall
  short.
- A committed `graph.json` is rewritten whole on each build; don't flag its
  large diff as churn or suggest skipping the rebuild or its hooks.

### Local project notes

Kept out of the dotfiles repo; the file may not exist on every machine. Read
it at the start of every conversation, before any other step, plus every file
a notes file says to read "before any work" (e.g. a branch list).

@~/.claude/local.md
