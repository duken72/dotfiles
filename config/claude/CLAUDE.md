# Global instructions

## Table of contents

<!-- vim-markdown-toc GFM -->

* [graphify](#graphify)
* [Default coding style](#default-coding-style)
* [Writing comments and documentation](#writing-comments-and-documentation)
* [Suggesting documentation updates](#suggesting-documentation-updates)
* [Citing references](#citing-references)
* [Renaming and restructuring](#renaming-and-restructuring)
* [Commits and pushes](#commits-and-pushes)
* [Syncing branches](#syncing-branches)
* [Tracking temporary changes](#tracking-temporary-changes)
* [Drafting PR descriptions](#drafting-pr-descriptions)
* [Local project notes](#local-project-notes)

<!-- vim-markdown-toc -->

## graphify

When the user types `/graphify`, invoke the graphify skill
(`~/.claude/skills/graphify/SKILL.md`) before doing anything else. The skill
turns any input, such as code, docs, papers, or images, into a knowledge graph.

When a repo has `graphify-out/graph.json`:

- Before your first grep, search or source-file read for a codebase question,
  run `graphify query "<question>"`. Put this rule in every subagent prompt
  that explores code. Read raw files only for lines that the graph or an
  earlier read already located.
- Use `graphify path "<A>" "<B>"` for relationships and
  `graphify explain "<concept>"` for focused concepts. Both return a scoped
  subgraph, usually much smaller than `GRAPH_REPORT.md` or raw grep output.
- If `graphify-out/wiki/index.md` exists, use it for broad navigation instead
  of browsing raw source.
- Read `graphify-out/GRAPH_REPORT.md` only for a broad architecture review, or
  when query, path and explain don't give enough context.
- If `graph.json` is committed, every build rewrites it whole, so a large diff
  to it in a pull request is expected. Don't flag it as churn, and don't
  suggest skipping the graph rebuild or its hooks.

## Default coding style

Apply these defaults only when the working repo has no docs or config for
coding guidelines, style, formatting, or linting. The repo's own guidelines and
config always take precedence.

The defaults are the formatters, linters, and settings from my Neovim config.
Read the files below for the current setup instead of assuming it.

In `~/.config/nvim` (a symlink to `~/.dotfiles/config/nvim`):

- `lua/plugins/conform.lua`: the formatter for each filetype, with its
  arguments.
- `lua/plugins/nvim-lint.lua`: the linter for each filetype.
- `lua/vim-settings.lua`: indentation (4 spaces, no tabs).

Elsewhere:

- `~/.dotfiles/config/vale/.vale.ini`: the prose styles (Google, proselint,
  write-good) for `vale`, the Markdown linter.

## Writing comments and documentation

When you write or edit comments or documentation, consider rephrasing the
wording so that both human readers and AI agents can understand it more easily.

## Suggesting documentation updates

When you discover something about a repo or code base that isn't documented and
would help later work, by human developers or AI agents, suggest an update to
the relevant documentation. Examples are an undocumented build step, a hidden
dependency, a misleading name, or documentation that no longer matches the
code.

Make the suggestion at the end of your work: say what you found and which file
it belongs in. Don't edit the documentation unless I ask for it.

## Citing references

- Whenever you explain something, always cite the reference, and put each
  reference right after the claim, bullet or paragraph it supports, not
  collected at the end of the answer. For example:
  - `- The timeout defaults to 30 s. [Ref: config.yaml (line 2)]`
  - `- The parser skips empty lines. [Ref: parser.py (line 7), R.md (line 7)]`
- Cite only sources that existed before you touched them: other documentation,
  existing code or files, git history. Don't cite files or code you wrote or
  changed in this session to back up a claim about them; that is citing
  yourself. If the only source is your own work, say so (e.g. "this is how I
  wrote it") instead of a `[Ref: ...]`.

## Renaming and restructuring

Before renaming, moving or restructuring files or folders, check what else in
the repo references them and whether the change goes against the repo's coding
style or conventions (written rules first, then what sibling folders do). If it
does, warn before making the change.

## Commits and pushes

- Do **not** commit or push unless explicitly asked to; leave changes
  uncommitted for review.
- When asked to commit or push, make small, reasonable commits of related
  changes, each with a suitable commit message. If asked to push changes, make
  the commits first, then push.

## Syncing branches

At the start of every conversation in a git repo, update the local and remote
branches before any other work:

1. Run `git fetch --all --prune`. This updates the remote-tracking refs and
   removes the ones whose remote branch is gone.
2. Fast-forward each local branch that is behind its upstream and hasn't
   diverged from it:
   - For a branch that isn't checked out in any worktree, run
     `git fetch <remote> <branch>:<branch>`.
   - For a branch that is checked out in a worktree, run
     `git -C <worktree> merge --ff-only`, but only if that worktree has no
     uncommitted changes.
3. Leave alone any branch that has diverged from its upstream, and any
   checked-out branch whose worktree has uncommitted changes. Don't delete,
   rebase, or push anything as part of this step.
4. In one or two lines, tell me what changed, and list the branches you skipped
   and why.

## Tracking temporary changes

A temporary change exists only to support development on a branch and must not
be merged with it. Examples are files or commits copied from another branch
that isn't merged yet, generated output such as `graphify-out/`, debug code,
and local config overrides.

Files or changes pulled from another branch are usually temporary. When I ask
you to pull changes from another branch, ask me whether to list them in
`TEMPORARY_CHANGES.md`.

Keep a list of them in `TEMPORARY_CHANGES.md` in the repo root:

- Create the file when the first temporary change appears. I work on several
  machines, so the file is tracked and pushed with the branch, like the
  temporary changes themselves. The file is itself temporary: list it as its
  own entry.
- For each entry, name the files or commits, say why they're temporary, and say
  when they can be removed. If I don't say when, the default is: before the
  pull request.
- Update the file whenever you add or remove a temporary change, or when I tell
  you that something is temporary.
- Keep temporary changes in their own commits, separate from the real work, so
  that they can be dropped cleanly.

When I ask you to draft a pull request description, to review a pull request or
branch, or to clean up a branch for a pull request, read the file and suggest
removing its entries, including the file itself. Only suggest: don't remove
anything unless I ask for it.

## Drafting PR descriptions

Review the changes before drafting the description, so it describes the
final code:

- When I ask you to draft a pull request description and no review has run
  on the changes yet, remind me to run the `ponytail-review` skill
  (`/ponytail-review`) or a review skill (e.g. `/code-review`) first. Only
  remind me: don't run the skill unless I ask for it.
- After such a review has run and its fixes are applied, suggest drafting
  (or redrafting) the pull request description. Only suggest it: don't
  draft it unless I ask for it.

When writing a PR description, use the repo's own PR template if it has one
(e.g. `.github/pull_request_template.md`). Otherwise, read
`~/.claude/pr-template.md` first and follow it (fixed sections, max 4000
characters).

## Local project notes

Kept out of the dotfiles repo; the file may not exist on every machine.

@~/.claude/local.md
