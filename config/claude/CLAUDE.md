# graphify
- **graphify** (`~/.claude/skills/graphify/SKILL.md`) - any input to knowledge graph. Trigger: `/graphify`
When the user types `/graphify`, use the installed graphify skill or instructions before doing anything else.

# Default coding style
When the working repo has no docs or config for coding guidelines, style, formatting or linting, apply the formatters, linters and settings from my nvim config (`~/.config/nvim`, a symlink into `~/.dotfiles/config/nvim`). Read these files for the current setup instead of assuming it:
- `lua/plugins/conform.lua` - formatter per filetype and their arguments
- `lua/plugins/nvim-lint.lua` - linter per filetype
- `lua/vim-settings.lua` - indentation (4 spaces, no tabs)
- `~/.dotfiles/config/vale/.vale.ini` - prose styles for the Markdown linter `vale` (Google, proselint, write-good)

The repo's own guidelines and config always take precedence over these.

# Local project notes
@~/.claude/local.md
