---
name: pr-desc
description: Draft or update PR_DESCRIPTION.md for the current branch from its commits and diff. Use when asked to draft, write or update a PR description. Also use when the user shares the posted description, to compare it with PR_DESCRIPTION.md.
argument-hint: "[base branch] [notes on the change]"
---

Before the fork: if no review skill ran on this branch in this conversation,
remind the user (`🔔 REMINDER:`) to run `/ponytail-review` or a review skill
(e.g. `/code-review`); don't run it unless asked. If the user shared the
posted description, skip the fork: say where it differs from
`PR_DESCRIPTION.md`, and overwrite neither without asking.

Do the steps below in one fork (`Agent` with `subagent_type: "fork"`, which
inherits this conversation), then relay its reply unchanged.

Draft `PR_DESCRIPTION.md` in the repo root for the current branch, or bring an
existing one in line with the final code.

Arguments: $ARGUMENTS

1. Base branch: the first argument if it names a branch, else the remote
   default branch (`git symbolic-ref --short refs/remotes/origin/HEAD`). Fetch
   it, then read `git log --oneline origin/<base>..HEAD`,
   `git diff --stat origin/<base>...HEAD` and the diff. Treat the other
   arguments as notes on the change.
   Take the problem, the reasons for decisions and the test runs from the
   conversation too; the diff alone doesn't say why.
   If this worktree's root has `SPEC.md`, `PLAN.md` or `TODO.md`, read them for
   an overview of the task, branch and PR.
2. Template: the repo's own wins
   (`.azuredevops/pull_request_template.{md,txt}`,
   `.github/pull_request_template.md`, `docs/pull_request_template.md`, or a
   `pull_request_template/` folder in `.azuredevops/` or `.github/`); otherwise
   `~/.claude/pr-template.md`.
3. Rules:
   - Fill the template's sections; remove its instruction text (`[DELETE]`,
     `[CHANGE]`).
   - At most 4000 characters; check with `wc -m`, shorten and recount until it
     fits.
   - No title line, work item link or "Generated with Claude Code" line.
   - No hard wrap: each sentence and list item (checklist items too) on one
     line.
   - Go from high level to low level, as plain cause and effect: the problem
     and what the user saw, the fix in a few sentences, a small data-flow
     sketch if components connect, then the file list. Add a worked example
     with numbers for timing or arithmetic.
   - Testing: take values only from real runs of this branch (`~/ci-results/`
     folders, test output), never made up; say which run each value is from.
     When new results come in, replace every Testing value from an older run or
     base, not only the changed one, unless it says which run it's from.
4. `PR_DESCRIPTION.md` is temporary: list it in `TEMPORARY_CHANGES.md` in the
   repo root (create that file with this first entry if it's missing). Leave
   both untracked: don't add them to any exclude file, and don't stage, commit
   or push them unless the user asks.
5. Reply with one line: the file path and its character count. Don't paste or
   summarize the description.
