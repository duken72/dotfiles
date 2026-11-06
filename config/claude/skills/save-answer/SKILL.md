---
name: save-answer
description: Save the answer just given in chat to <YYYY-MM-DD>-<topic>.md in the repo root through a fork, so the user can copy-paste it. Run only when the user types /save-answer.
disable-model-invocation: true
argument-hint: "[topic]"
---

Save the answer you last gave in chat to a Markdown file.

1. Path: `<YYYY-MM-DD>-<topic>.md` (today's date; the topic from the
   arguments, else a short kebab-case one) in the repo root
   (`git rev-parse --show-toplevel`), or the working directory outside a
   repo. Write the full path in your reply before the spawn.
2. Spawn one fork (`Agent` with `subagent_type: "fork"`). Its prompt must
   hold the complete answer text, citations included, copied from your reply
   between `=== BEGIN ===` and `=== END ===`. A fork doesn't see reply text
   from the turn that spawns it, so "write the answer above" gives it nothing
   to write.
3. Tell the fork to write that text verbatim under a `# <title>` heading, with
   each sentence and list item on one line (no hard wrap), and to leave the
   file untracked: don't stage, commit or add it to an exclude file.
4. End the turn with `⏳ Agent <description>` (see `subtasks.md`); relay the
   fork's result in one line.
