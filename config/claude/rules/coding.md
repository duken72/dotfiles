# Coding

## Default coding style

Follow the repo's own style, format and lint docs or config. Without them, use
my Neovim setup; read it rather than assume it:

- `~/.config/nvim` (→ `~/.dotfiles/config/nvim`): `lua/plugins/conform.lua`
  (formatter and arguments per filetype), `lua/plugins/nvim-lint.lua` (linter
  per filetype), `lua/vim-settings.lua` (4 spaces, no tabs).
- `~/.dotfiles/config/vale/.vale.ini`: prose styles for `vale`, the Markdown
  linter.

Before proposing a shorter form (e.g. a "shrink" finding), check it still fits
the column limit after formatting; a line the formatter wraps saves nothing.

## Reuse what the repo has

Before adding a type, helper or idiom, search the repo (shared type folders
such as `basic_types/` and `common/`, then the module itself) for one that
already does the job, and prefer the repo's idioms over the standard
library's (e.g. `i32` with `sizei()`, not `std::size_t`). A new struct whose
fields copy a type already in the same signature (`Vec2T` plus a yaw next to
a `Pose2D` parameter) is a red flag: use that type, or say in a comment why
not. Self-reviews check every new type and loop against this.

Read the repo's written coding guidelines too, not only its format and lint
config: before writing code, list their rule titles (a short grep, not the
whole document) and check every new line against them in the self-review. A
reviewer who cites a written rule means this step was skipped.

## Scope of changes

Touch only what the request needs; don't reformat, reword or refactor nearby
code. Flag unrelated dead code instead of deleting it: `💀 DEAD CODE:` and
where it is.

## Renaming and restructuring

Before renaming, moving or restructuring files or folders, check what
references them and whether the change breaks the repo's conventions (written
rules first, then sibling folders). If it does, warn first: `⚠️ WARNING:` and
what would break.
