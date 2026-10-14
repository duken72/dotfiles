# Personal instructions (all projects)

- Whenever you explain something, always cite the reference, and put each reference right after the claim, bullet or paragraph it supports, not collected at the end of the answer. E.g. `- The DBC defines EPS_Steering_angle as "Positive, to left". [Ref: chassis.dbc (line 1363)]` then `- The feeder integrates its own pose. [Ref: sim_feeder.h (line 557-575), doc.rst (line 7-9)]`.
  - Cite only sources that existed before you touched them: other documentation, existing code or files, git history. Don't cite files or code you wrote or changed in this session to back up a claim about them; that is citing yourself. If the only source is your own work, say so (e.g. "this is how I wrote it") instead of a `[Ref: ...]`.
- Before renaming, moving or restructuring files or folders, check what else in the repo references them and whether the change goes against the repo's coding style or conventions (written rules first, then what sibling folders do). If it does, warn before making the change.
- Do **not** commit or push unless explicitly asked to; leave changes uncommitted for review.
- When asked to commit or push, make small, reasonable commits of related changes, each with a suitable commit message. If asked to push changes, make the commits first, then push.
- When writing a PR description, read `~/.claude/pr-template.md` first and follow it (fixed sections, max 4000 characters).

# Machine-specific notes

Kept out of the dotfiles repo; the file may not exist on every machine.

@~/.claude/local.md
