---
name: instruct
description: Change how Claude works for the user by picking the best place for the instruction (CLAUDE.md, AGENTS.md, project notes, a skill, a command, a subagent, a hook or memory), then applying it after approval. Run only when the user types /instruct.
argument-hint: "<what Claude should do differently>"
disable-model-invocation: true
---

Turn the user's request into an instruction in the place where it works best.

Request: $ARGUMENTS (also read the conversation: what went wrong, or what
the user wants repeated)

1. In one fork (`Agent` with `subagent_type: "fork"`, which inherits this
   conversation), decide without editing anything:
   - Grep the candidate targets below for a rule on the same topic.
     Sharpening an existing rule beats adding one; a rule that contradicts
     the request gets replaced, not joined by a second one.
   - Pick one target with the guide below and draft the exact text (new
     lines, or old → new lines).
   - Return: the target file, the exact text, one line on why, and one line
     on the runner-up and why it lost.
2. Show the user the recommendation (file and exact text, no more) and ask
   with AskUserQuestion: the recommendation first with "(Recommended)", the
   runner-up second, and any other reasonable target.
3. In a second fork, apply the chosen option:
   - Files in `~/.dotfiles` or `~/WS/adle-vf`: edit, don't commit (the user
     runs `/sync <repo> push`).
   - A new skill: create `~/.dotfiles/config/claude/skills/<name>/SKILL.md`,
     link it with
     `ln -svfn ~/.dotfiles/config/claude/skills/<name> ~/.claude/skills/`,
     and add it to the `skills/` bullet of
     `~/.dotfiles/config/claude/README.md`.
   - A repo `AGENTS.md` or `CLAUDE.md` (committed, shared with the team):
     edit it only because the user chose it, and leave it uncommitted for
     their PR.
   - A hook or setting: use the `update-config` skill.
4. Reply with one line: `📌 RULE UPDATE: <file> — <what changed>`.

## Where an instruction belongs

| Target | Use it when |
|---|---|
| Global rules `~/.dotfiles/config/claude/rules/<topic>.md` (= `~/.claude/rules/`, loaded in every session) | A rule for every repo and most tasks. At most ~3 lines, in the topic file and section it belongs to; move details into a skill or notes file and leave a pointer. |
| Repo `AGENTS.md` / `CLAUDE.md` | A repo fact that every agent and developer needs. It's committed and shared with the team. |
| Project notes (`~/WS/adle-vf/claude/<project>*.md`, routed by `~/.claude/local.md`) | A personal, repo-specific fact the repo docs don't have. Component notes when only some tasks need it. Covers every worktree of the repo. |
| Existing skill (`~/.dotfiles/config/claude/skills/*/SKILL.md`) | The request is about how a skill behaves (its steps, its report). |
| New skill | A repeatable multi-step workflow. It loads only when used, so it keeps the global rules short. `context: fork` if it doesn't need the chat and its output is noisy; a body that spawns a `fork` agent if it needs the chat; `disable-model-invocation: true` if it deletes, pushes or publishes. |
| Command (`~/.dotfiles/config/claude/commands/*.md`) | Only a tiny prompt shortcut that must run in the main chat, like `/st`. Otherwise a skill. |
| Subagent (`~/.claude/agents/*.md`) | A persona Claude should delegate to on its own, with its own system prompt, tool limits or model (e.g. a read-only reviewer). Rare. |
| Hook (`~/.claude/settings.json`) | Something that must always or never happen, enforced so the model can't forget. |
| Auto-memory (`~/.claude/projects/<folder>/memory/`) | A small preference tied to one working folder. Last resort: it's stored per folder, so `~/WS/adasvf2` doesn't see what `~/WS/adasvf` saved. |

Write the rule, not the incident. Follow the global rules on writing (`rules/writing.md`):
plain cause and effect, names over pronouns, Unicode 6 emoji only.
