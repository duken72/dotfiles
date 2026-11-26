---
name: prune-branches
description: Prune merged or canceled local branches of the adasvf repo and their entries in the branch notes. Run only when the user types /prune-branches.
argument-hint: "[branch ...]"
disable-model-invocation: true
---

Prune dead local branches of the adasvf repo. `~/WS/adasvf`, `~/WS/adasvf2`
and `~/WS/adasvf3` are worktrees of one repo. Follow the "Upkeep" section of
`~/WS/adle-vf/claude/adasvf-branches.md`; it defines when a branch counts as
merged.

Arguments (branches to check; default: every local branch): $ARGUMENTS

1. In one fork (`Agent` with `subagent_type: "fork"`), prune without asking
   the user:
   - Run `git fetch --prune origin`, `git worktree prune`,
     `git worktree list` and `git branch -vv`.
   - For each local branch except the default branch (`origin/HEAD`), take
     the work item number from the start of its name and look for its merge
     commit:
     `git log origin/HEAD --merges --oneline --grep "Merged PR [0-9]*: <work item>"`.
     List the branch's commits that aren't in the default branch:
     `git log --oneline origin/HEAD..<branch>`.
   - Verdict: `merged` (merge commit found), `gone` (upstream marked
     `[gone]`, no merge commit: not proof) or `active`.
   - Delete every `merged` branch, even one with commits made after its PR
     (record their subjects for the report):
     - If it's checked out in a worktree: when that worktree's
       `git status --porcelain` is empty, free it with
       `git -C <worktree> checkout --detach origin/HEAD`; otherwise skip the
       branch and report why.
     - Delete it with `git branch -D <branch>` (`-d` refuses branches merged
       only through a merge commit into another branch). Record the old tip
       hash it prints.
     - Delete its entry in `adasvf-branches.md` and every mention of it in
       the other entries.
   - Don't delete `gone` or `active` branches. Report them instead. Also
     report an `active` branch whose commits are all in the default branch
     (likely merged through another branch's PR).
   - Don't delete remote branches or worktree folders, and don't commit
     anything (the adle-vf repo included).
2. Relay one line: deleted branches with their old tip hashes and any lost
   commit subjects, skipped ones with the reason, and `gone` or `active`
   branches worth a look.
