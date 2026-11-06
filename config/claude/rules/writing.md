# Writing and answers

## Writing comments and documentation

Write comments, docs and chat answers so both humans and AI agents follow
them easily:

- Explain a risk or mechanism as plain cause and effect (what happens, when,
  what the user sees), not one dense clause of jargon.
- For a sign or direction (positive, left, "opposite sign"), name the
  quantity, what it's compared with and the condition (e.g. "for a left turn
  in R"); when two signs interact, add a worked example with numbers.
- For a predicted test result, say "passes" or "fails" and the margin against
  its tolerance, with numbers.

When moving content out of `AGENTS.md` or `CLAUDE.md` into a doc, keep there
what agents need on most tasks (rules they'd otherwise miss, frequent build,
test and format commands), even if the doc repeats them. Move explanations,
background and rare details to the doc, and leave a pointer.

Use only older emoji (Unicode 6, e.g. 🔴 📝 ⚠️ 👉); newer ones such as
U+1F900 and up (🧹, 🧠) show as empty boxes in my terminal font.

## Saving answers as Markdown

When I ask for an answer, explanation or report, give it in chat as usual and
also write the same text, citations included, to `<YYYY-MM-DD>-<topic>.md` in
the repo root (the working directory outside a repo), so I can copy-paste it.
In that file, don't hard-wrap: put each sentence and list item on one line.
Write it through a fork (see `subtasks.md`): put the full answer text
in the fork prompt, since a fork doesn't see reply text from the turn that
spawns it, and give the file's full path before the spawn. Leave the file
untracked: don't stage, commit or exclude it. Skip one-line replies and status
updates.

## Suggesting documentation updates

When you find something undocumented that would help later work (a build step,
a hidden dependency, a misleading name, docs that no longer match the code),
flag it at the end of your reply as `📝 DOC UPDATE:` with what you found and
which file it belongs in. Don't edit the docs unless I ask.

When two docs, or a doc and the code, contradict each other, flag it as
`🔴 ERROR:` with both sides.

<!-- TEMPORARILY DISABLED: Learning from mistakes
## Learning from mistakes

Whenever you make a mistake (I correct you, or you find it yourself), update
the agent instructions so it doesn't recur; this standing request overrides
the preceding rule.

- Repo-specific: the repo's `AGENTS.md` or `CLAUDE.md`, or its notes file
  (see `~/.claude/CLAUDE.md`).
- General: the topic file it belongs in under
  `~/.dotfiles/config/claude/rules/`.
- Write the rule, not the incident, in the section it belongs to; sharpen an
  existing rule rather than add a near-duplicate.
- Tell me in one line, `📌 RULE UPDATE:`, which file changed and why.
-->

## Long suggestion lists

When suggestions, open questions or to-dos are too many to read comfortably in
chat, write them to `TODO.md` (`PLAN.md` for a plan) in the repo root, one
checkbox each, and reply only with e.g. `👉 CHECK:` TODO.md (answer is too
long). Don't repeat the file in chat. When either of us addresses an item,
tick it and note the outcome.

## Citing references

- Cite the source in backticks right after the claim, bullet or paragraph it
  supports, not at the end: `[Ref: config.yaml (line 2)].` or
  `[Ref: parser.py (line 7), R.md (line 7)].`
- Cite only sources that existed before you touched them. If your own work
  this session is the only source, say so ("this is how I wrote it").
- Take line numbers only from a read of that one file (Read, `grep -n`,
  `sed -n`); output joining several files (`cat *.yml`) numbers lines across
  all of them.

## Writing bug reports

When I ask for a bug report, use the `bug-report` skill
(`skills/bug-report/SKILL.md`).
