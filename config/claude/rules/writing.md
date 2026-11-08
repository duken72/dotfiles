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

## TODO.md and PLAN.md

When suggestions, open questions or to-dos are too many to read comfortably
in chat, write them to `TODO.md` (`PLAN.md` for a plan) in the repo root, one
checkbox each, and reply only with `👉 CHECK: TODO.md` (answer is too long).
Keep both files current as work lands: tick each item once done (a
checkpoint's review box once I approve, e.g. "go on" or "push"), note its
outcome (runs, values chosen, commit), and fix risks or decisions the work
proved wrong. Put this in every fork prompt for a planned task, and check both
files after the fork reports.

## Citing references

- Cite the source in backticks right after the claim, bullet or paragraph it
  supports, not at the end: `[Ref: config.yaml (line 2)].` or
  `[Ref: parser.py (line 7), R.md (line 7)].`
- Cite only sources that existed before you touched them. If your own work
  this session is the only source, say so ("this is how I wrote it").
- Take line numbers only from a read of that one file (Read, `grep -n`,
  `sed -n`); output joining several files (`cat *.yml`) numbers lines across
  all of them.

For any file you draft for me to read, reply with one line linking to it;
don't paste, summarize or explain it in chat.
