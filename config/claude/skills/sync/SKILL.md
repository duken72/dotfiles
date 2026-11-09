---
name: sync
description: 'Sync git repos with their remote: pull, resolve conflicts, and with "push" commit and push all or chosen changes. Run only when the user types /sync.'
argument-hint: "[adasvf | dotfiles | adle-vf | <path> ...] [push [all | <paths or description>]]"
disable-model-invocation: true
---

Do the steps below in one fork (`Agent` with `subagent_type: "fork"`, which
inherits this conversation), then relay its reply unchanged.

Arguments: $ARGUMENTS

Repos: `adasvf` is the current worktree if it's one of `~/WS/adasvf*`, else
`~/WS/adasvf`; `dotfiles` is `~/.dotfiles`; `adle-vf` is `~/WS/adle-vf`;
anything else is a path. No repo named: the current repo. Several: one after
the other.

For each repo:

1. Run `git fetch --prune origin`, then read `git status` and the current
   branch. If the branch has no upstream, skip the pull.
2. Pull with `git pull --autostash`: a merge, since these repos set
   `pull.rebase=false`. Uncommitted changes stay uncommitted.
3. Resolve conflicts from both sides' intent: read each side's recent commits
   for the file (`git log --oneline -3 HEAD -- <file>`, same for
   `MERGE_HEAD`) and the conversation, and keep both sides' changes where they
   don't contradict. If the right answer isn't clear, run `git merge --abort`
   and report the file and the two sides in one line each; don't guess. After
   resolving, run `git diff --check` (and the build or test the conversation
   used, for code), then finish the merge with `git commit --no-edit`.
4. Without `push` in the arguments, stop here: don't commit local changes.
5. With `push`: commit the changes named after `push` (nothing or `all`:
   every uncommitted change; paths or a description: only those), following
   steps 2 to 5 of
   `~/.claude/skills/commit/SKILL.md` (skip temporary files, small commits,
   branch check). Leave every other change uncommitted. Then push the branch
   by name:
   `test "$(git branch --show-current)" = <branch> && git push origin <branch>`.
   Never force-push; if the push is rejected, report it.
6. Reply with one line per repo: commits pulled (or up to date), conflicts
   resolved or aborted, commits made (short hash and subject), pushed or not,
   and changes left uncommitted.
