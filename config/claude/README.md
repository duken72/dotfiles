# Claude Code configuration

`run.sh` symlinks the files below into `~/.claude/`. This README is not
linked.

- `CLAUDE.md`: global instructions, loaded in every Claude Code session.
- `pr-template.md`: default pull request template.
- `settings.json`: shared settings and plugins. `run.sh` copies it into
  `~/.claude` once instead of linking it, so machine-specific settings stay
  local.
- `statusline.sh`: the status line script that `settings.json` runs.
- `commands/`: custom slash commands, linked as a folder: `/st` runs a task in
  one fork subtask, `/sts` splits it across parallel forks.
- `brave-mcp.json`, `brave-live-mcp.json`: opt-in browser access, see below.

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Browser access with Brave](#browser-access-with-brave)
   * [Use your running Brave (`clabl`)](#use-your-running-brave-clabl)
   * [Use a separate Brave window (`clab`)](#use-a-separate-brave-window-clab)

<!-- vim-markdown-toc -->

## Browser access with Brave

Both files run the [Chrome DevTools MCP
server](https://github.com/ChromeDevTools/chrome-devtools-mcp), which gives
Claude tools to list tabs, read pages, click, type and take screenshots.

`--mcp-config` loads them for one session only, so they don't appear in
`claude mcp list`. A plain `claude` (or `cla`) session has no
browser tools.

| Alias   | File                  | What Claude controls                         |
| ------- | --------------------- | -------------------------------------------- |
| `clab`  | `brave-mcp.json`      | A new, separate Brave window (clean profile) |
| `clabl` | `brave-live-mcp.json` | Your running Brave, with all its open tabs   |

### Use your running Brave (`clabl`)

1. In Brave, open `brave://inspect/#remote-debugging` and turn on remote
   debugging. Brave then writes its debugging port to
   `~/.config/BraveSoftware/Brave-Browser/DevToolsActivePort`.
2. Start Claude Code with `clabl`.

If you skip step 1, the server exits with this error: `Turn on remote
debugging at brave://inspect/#remote-debugging first`.

To stop:

1. Exit Claude Code, or start the next session with `cla` instead.
2. Turn remote debugging off again at `brave://inspect/#remote-debugging`.

> [!WARNING]
> While remote debugging is on, any local process can read and control every
> tab, including logged-in sessions such as email. Turn it off when you're
> done.

### Use a separate Brave window (`clab`)

Start Claude Code with `clab`. The server starts its own Brave from
`/usr/bin/brave`, so remote debugging doesn't need to be on, and your own tabs
stay out of reach.
