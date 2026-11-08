---
name: commit
description: Commit the current changes as small related commits, and push the branch when "push" is given. Run only when the user types /commit.
argument-hint: "[push] [message hints]"
disable-model-invocation: true
---

Do the steps below in one fork (`Agent` with `subagent_type: "fork"`, which
inherits this conversation), then relay its reply unchanged.

Commit the working-tree changes of the current repo; push only if the arguments
contain `push`.

Arguments: $ARGUMENTS

1. Read `git status`, `git diff`, `git diff --staged`, the branch name
   (`git branch --show-current`) and `git log -10 --oneline` for the message
   style.
2. Skip temporary files: everything listed in `TEMPORARY_CHANGES.md` or in
   `$(git rev-parse --git-common-dir)/info/exclude`, and `SPEC.md`, `PLAN.md`,
   `TODO.md`, `PR_DESCRIPTION.md`, `TEMPORARY_CHANGES.md`. List any you skipped
   in the reply; never commit them without the user's explicit yes.
3. Group related changes into small commits. Use the message hints from the
   arguments, the repo's message style, and end each message with the
   Co-Authored-By line from the session's attribution instructions.
   Use the conversation to know which changes belong together and why.
4. In every commit and push command, check the branch first:
   `test "$(git branch --show-current)" = <branch> && git commit ...`. The user
   switches branches between turns.
5. To untrack files, commit the `git rm --cached` without a pathspec (check
   that nothing else is staged first): `git commit -- <paths>` commits the
   working-tree version of the paths, so it adds the files back instead of
   removing them.
6. With `push`: check `git show --stat HEAD`, then push the branch by name:
   `test "$(git branch --show-current)" = <branch> && git push origin <branch>`
   (add `-u` if it has no upstream). If the push is rejected, report it; never
   force-push.
7. Reply with one line per commit (short hash and subject), whether it was
   pushed, and any skipped files.
