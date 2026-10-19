# Global instructions

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Coding](#coding)
  * [Default coding style](#default-coding-style)
  * [Scope of changes](#scope-of-changes)
  * [Renaming and restructuring](#renaming-and-restructuring)
* [Documentation and answers](#documentation-and-answers)
  * [Writing comments and documentation](#writing-comments-and-documentation)
  * [Suggesting documentation updates](#suggesting-documentation-updates)
  * [Long suggestion lists](#long-suggestion-lists)
  * [Citing references](#citing-references)
* [Git and pull requests](#git-and-pull-requests)
  * [Commits and pushes](#commits-and-pushes)
  * [Syncing branches](#syncing-branches)
  * [Tracking temporary changes](#tracking-temporary-changes)
  * [Drafting PR descriptions](#drafting-pr-descriptions)
* [Context](#context)
  * [graphify](#graphify)
  * [Local project notes](#local-project-notes)

<!-- vim-markdown-toc -->

## Coding

### Default coding style

Only when the repo has no docs or config for coding guidelines, style,
formatting or linting (those always win), default to my Neovim setup. Read
these files for the current setup instead of assuming it:

- `~/.config/nvim` (symlink to `~/.dotfiles/config/nvim`):
  `lua/plugins/conform.lua` (formatter and arguments per filetype),
  `lua/plugins/nvim-lint.lua` (linter per filetype), `lua/vim-settings.lua`
  (indentation: 4 spaces, no tabs).
- `~/.dotfiles/config/vale/.vale.ini`: prose styles (Google, proselint,
  write-good) for `vale`, the Markdown linter.

### Scope of changes

Touch only what the request needs: don't reformat, reword or refactor adjacent
code. Mention unrelated dead code instead of deleting it.

### Renaming and restructuring

Before renaming, moving or restructuring files or folders, check what in the
repo references them and whether the change breaks the repo's conventions
(written rules first, then what sibling folders do). If it does, warn first.

## Documentation and answers

### Writing comments and documentation

When writing or editing comments or docs, consider rephrasing so both humans
and AI agents understand them more easily.

### Suggesting documentation updates

When you find something undocumented that would help later work by humans or
AI agents (an undocumented build step, a hidden dependency, a misleading name,
docs that no longer match the code), suggest a docs update at the end of your
work: what you found and which file it belongs in. Don't edit the docs unless
I ask.

### Long suggestion lists

When a list of suggestions, open questions or to-dos is too long to read
comfortably in chat:

- Write it to `TODO.md` (or `PLAN.md` for a plan) in the repo root, one
  checkbox per item.
- Reply with one short line only, e.g. "Check TODO.md (answer is too long)".
  Don't summarize or repeat the file in chat; I read it.
- Whenever an item is addressed, by you or me, tick it and note the outcome.

### Citing references

- Whenever you explain something, cite the reference right after the claim,
  bullet or paragraph it supports, not at the end. For example:
  - `- The timeout defaults to 30 s. [Ref: config.yaml (line 2)]`
  - `- The parser skips empty lines. [Ref: parser.py (line 7), R.md (line 7)]`
- Cite only sources that existed before you touched them (other docs, existing
  code or files, git history). Citing what you wrote or changed this session
  is citing yourself; if your own work is the only source, say so (e.g. "this
  is how I wrote it") instead of a `[Ref: ...]`.

## Git and pull requests

### Commits and pushes

- Don't commit or push unless explicitly asked; leave changes uncommitted for
  review.
- When asked, make small commits of related changes with suitable messages;
  to push, commit first, then push.

### Syncing branches

At the start of every conversation in a git repo, before any other work:

1. Run `git fetch --all --prune` (updates remote-tracking refs, removes ones
   whose remote branch is gone).
2. Fast-forward each local branch that is behind its upstream and hasn't
   diverged: `git fetch <remote> <branch>:<branch>` if it isn't checked out in
   any worktree, else `git -C <worktree> merge --ff-only` if that worktree has
   no uncommitted changes.
3. Leave diverged branches, and checked-out branches with uncommitted changes,
   alone. Don't delete, rebase or push anything in this step.
4. Tell me in one or two lines what changed, and which branches you skipped
   and why.

### Tracking temporary changes

A temporary change only supports development on a branch and must not be
merged with it: e.g. files or commits copied from an unmerged branch,
generated output such as `graphify-out/`, debug code, local config overrides,
the draft `PR_DESCRIPTION.md` (see [Drafting PR
descriptions](#drafting-pr-descriptions)). Changes pulled from another branch usually are; when I ask you to pull some,
ask whether to list them in `TEMPORARY_CHANGES.md`.

List them in `TEMPORARY_CHANGES.md` in the repo root:

- Create it with the first temporary change. It's tracked and pushed with the
  branch (I use several machines), and is itself temporary, so list it too.
- Per entry: the files or commits, why they're temporary, and when they can go
  (default, if I don't say: before the pull request).
- Update it whenever you add or remove one, or I tell you something is
  temporary.
- Keep temporary changes in their own commits, apart from the real work, so
  they drop cleanly.

When I ask you to draft a PR description, review a PR or branch, or clean up a
branch for a PR, read the file and suggest removing its entries, the file
included. Only suggest; don't remove anything unless I ask.

### Drafting PR descriptions

Review the changes first, so the description matches the final code:

- If I ask for a PR description and no review has run yet, remind me to run
  `/ponytail-review` or a review skill (e.g. `/code-review`). Only remind;
  don't run it unless I ask.
- At the end of any review skill (`ponytail-review`, `code-review`, `review`
  or similar), ask whether to create `PR_DESCRIPTION.md`, or, if it exists,
  whether to check it against the final code. Ask even if nothing needed
  fixing; if there were fixes, ask after they're applied. Don't write it
  unless I say yes.

Keep the draft in `PR_DESCRIPTION.md` in the repo root:

- It's a temporary change: tracked and pushed, listed in
  `TEMPORARY_CHANGES.md` (removal: before the pull request), in its own
  commits.
- While it exists, re-check it after every commit or push in the session
  (changed files, test results, testing steps, character count) and update
  it without asking. Commit it separately if I asked for the commit or push;
  otherwise leave it uncommitted and tell me.
- If I share the description that's already posted, tell me where it differs
  from the file. Don't overwrite either without asking.

Use the repo's PR template if it has one (e.g.
`.github/pull_request_template.md`); otherwise read and follow
`~/.claude/pr-template.md` (fixed sections, max 4000 characters).

## Context

### graphify

When the user types `/graphify`, invoke the graphify skill
(`~/.claude/skills/graphify/SKILL.md`) first. It turns any input (code, docs,
papers, images) into a knowledge graph.

When a repo has `graphify-out/graph.json`:

- For a codebase question, run `graphify query "<question>"` before your first
  grep, search or source read, and put this rule in every code-exploring
  subagent prompt. Read raw files only for lines the graph or an earlier read
  already located.
- Use `graphify path "<A>" "<B>"` for relationships and
  `graphify explain "<concept>"` for concepts; their scoped subgraphs are
  usually far smaller than `GRAPH_REPORT.md` or grep output.
- Use `graphify-out/wiki/index.md`, if present, for broad navigation instead of
  raw source.
- Read `graphify-out/GRAPH_REPORT.md` only for a broad architecture review or
  when query, path and explain fall short.
- A committed `graph.json` is rewritten whole on every build, so a large PR
  diff to it is expected. Don't flag it as churn or suggest skipping the
  rebuild or its hooks.

### Local project notes

Kept out of the dotfiles repo; the file may not exist on every machine.

@~/.claude/local.md
