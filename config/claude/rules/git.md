# Git and pull requests

## Commits and pushes

When I ask in words to commit, follow `~/.claude/skills/commit/SKILL.md`
(small commits, branch check, untracking files); it's `/commit`-only.

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
