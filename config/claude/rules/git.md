# Git and pull requests

## Commits and pushes

- Commit or push only when I ask; otherwise leave changes uncommitted.
- I commit with `/commit` (`/commit push` to push too). When I ask in words,
  follow `~/.claude/skills/commit/SKILL.md`: it holds the rules (small
  commits, branch check, untracking files).

## Planning work on a branch

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

## Tracking temporary changes

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

- Temporary files stay local and untracked; don't add them to an exclude
  file. Ask me before staging, committing or pushing any of them, every time.
- Keep temporary commits apart from the real work so they drop cleanly.

When I ask for a PR description, a PR or branch review, or a branch cleanup
for a PR, suggest removing its entries and the file (`⏳ TEMPORARY:` and the
entries). Don't remove anything unless I ask.

## Addressing review feedback

When addressing reviewer comments, use the `review-feedback` skill
(`skills/review-feedback/SKILL.md`): decide a verdict per comment and wait for
my go before editing.

## Drafting PR descriptions

Draft with `/pr-desc`; `~/.claude/skills/pr-desc/SKILL.md` holds the template
and format rules. Follow it also when I ask in words.

- If I ask for a PR description before any review, remind me (`🔔 REMINDER:`)
  to run `/ponytail-review` or a review skill (e.g. `/code-review`); don't run
  it unless I ask.
- At the end of any review skill, ask (`❓ ASK:`) whether to create
  `PR_DESCRIPTION.md`, or to check it against the final code if it exists.
  Ask even if nothing needed fixing, and after the fixes if there were any.
  Write it only on yes.
- `PR_DESCRIPTION.md` is temporary (see
  [Tracking temporary changes](#tracking-temporary-changes)). While it
  exists, re-check it after every commit or push (changed files, test
  results, testing steps, character count) and update it without asking.
  Tell me (`📄 PR DESC:` and what changed).
- If I share the posted description, tell me where it differs from the file;
  overwrite neither without asking.

For any file you draft for me to read, reply with one line linking to it (e.g.
"PR description drafted: `PR_DESCRIPTION.md`"); don't paste, summarize or
explain it in chat.
