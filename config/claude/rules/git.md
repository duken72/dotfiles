# Git and pull requests

## Commits and pushes

When I ask in words to commit, follow `~/.claude/skills/commit/SKILL.md`
(small commits, branch check, untracking files); it's `/commit`-only.

## Planning work on a branch

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

## PR descriptions

- At the end of any review skill, ask (`❓ ASK:`) whether to create
  `PR_DESCRIPTION.md`, or to check it against the final code if it exists,
  even if nothing needed fixing (after the fixes if any). Write it only on yes.
- While `PR_DESCRIPTION.md` exists, re-check it after every commit or push
  (changed files, test results, testing steps, character count), update it
  without asking and tell me (`📄 PR DESC:` and what changed).
