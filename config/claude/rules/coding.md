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

## Scope of changes

Touch only what the request needs; don't reformat, reword or refactor nearby
code. Flag unrelated dead code instead of deleting it: `💀 DEAD CODE:` and
where it is.

## Renaming and restructuring

Before renaming, moving or restructuring files or folders, check what
references them and whether the change breaks the repo's conventions (written
rules first, then sibling folders). If it does, warn first: `⚠️ WARNING:` and
what would break.
