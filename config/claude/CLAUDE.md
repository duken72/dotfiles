# Global instructions

## Table of contents

<!-- vim-markdown-toc GFM -->

* [graphify](#graphify)
* [Default coding style](#default-coding-style)
* [Writing comments and documentation](#writing-comments-and-documentation)
* [Suggesting documentation updates](#suggesting-documentation-updates)
* [Tracking temporary changes](#tracking-temporary-changes)
* [Drafting PR descriptions](#drafting-pr-descriptions)
* [Local project notes](#local-project-notes)

<!-- vim-markdown-toc -->

## graphify

When the user types `/graphify`, invoke the graphify skill
(`~/.claude/skills/graphify/SKILL.md`) before doing anything else. The skill
turns any input, such as code, docs, papers, or images, into a knowledge graph.

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

When I ask you to draft a pull request description, remind me to run the
`ponytail-review` skill (`/ponytail-review`) on the changes. Only remind me:
don't run the skill unless I ask for it.

## Local project notes

@~/.claude/local.md
