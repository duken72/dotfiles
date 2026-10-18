# AGENTS.md

Guidance for AI coding agents working in this repository. Read
[README.md](README.md) first for the overview, repository layout, install
scripts and submodules.

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Verifying changes](#verifying-changes)
* [Branches](#branches)
* [Editing conventions](#editing-conventions)
* [Gotchas](#gotchas)

<!-- vim-markdown-toc -->

## Verifying changes

There is no build, lint, or test suite. A change is correct when the shell
scripts run cleanly and symlinks land where the relevant `run.sh`, `dfs.sh` or
`cfg.sh` says they should.

## Branches

- `main`: the primary branch.
- `ubuntu-support`: `main` plus Ubuntu-specific changes only:
  - **Packages:** see "Merging" below. Also, `pkg/README.md` drops the Arch
    LaTeX notes.
  - **nvim:** `nvim-treesitter` and its `-textobjects` are pinned to `master`,
    and the `all = false` shim is skipped before nvim 0.12
    (`config/nvim/lua/plugin_list.lua`). The outline symbol icons are
    replaced, since no installed font has the defaults
    (`config/nvim/lua/plugins/outline.lua`).
  - **ranger previews:** `sixel` in Windows Terminal
    (`config/ranger/plugins/sixel_preview.py`), `ueberzug` in Terminator
    (`config/ranger/rc.conf`) through the `bin/ueberzug` wrapper for Ubuntu's
    ueberzug 18.3.1, and SVG via GdkPixbuf, not `rsvg-convert`
    (`config/ranger/scope.sh`).
  - **Terminator:** the `PaneGeometry` plugin for `bin/ueberzug`
    (`config/terminator/plugins/`, `__pycache__` in `.gitignore`), enabled in
    `config/terminator/config`, which also sets font size 22.
- `legacy-xorg`: frozen snapshot of the old Xorg/Xfce+polybar setup at
  `2db86c2` (last commit before Wayland/Hyprland), minus `config/emptty` and
  `config/kitty`. Don't push to it unless asked. Only it keeps:
  - `config/`: `conky`, `htop`, `moc`, `neofetch`, `vis`, `vscode`,
    `logitech.md`, `NetworkManager`, `openvpn`, `pulseaudio-ctl`.
  - `bin/`: `imgcompress.sh`, `imgcompressDir.sh`, `pdfcompress.sh`,
    `pdfcompressDir.sh`, `vidcompress.sh`, `vidcompressDir.sh`,
    `renameSong.sh`; plus `os/test.sh`.
  - `dfs/`: `.pinerc`, `ipython/`, `.aliases_legacy`.

**Where changes go:**

- **Bug fixes:** all three branches, wherever the buggy code exists (e.g.
  cherry-pick). Leave no known bug on any branch.
- **Everything else:** both `main` and `ubuntu-support` (cherry-pick, or merge
  `main` into `ubuntu-support`), unless Ubuntu-specific, which stays on
  `ubuntu-support`. Nothing else goes to or from `legacy-xorg`.
- **Branch-specific changes** (kept, moved or deleted on only some branches):
  record them here in the same piece of work. Keep this file identical on all
  three branches.
- **Pushing:** push `main` and `ubuntu-support` together.

**Merging `main` into `ubuntu-support`:**

- Keep the Ubuntu-only files that `main` deleted: `os/ubuntu.md`,
  `pkg/apt_install.sh`, `pkg/pkg_apt.md` (formerly `pkg/Ubuntu/` on `main`).
- Keep the Arch-only paths deleted; resolve modify/delete conflicts by
  deleting:
  - `config/`: `cava`, `emptty`, `grub`, `hypr`, `waybar`, `wofi`.
  - `bin/`: `pkg_backup.sh`, `pkg_backup_pre.sh`, `revert-updates.sh`.
  - `dfs/hook/` (pacman hooks), `os/archlinux.md`, `os/run.sh`.
  - `pkg/`: `delta.sh`, `pacman_install.sh`, `pkg_*.txt` (pacman/AUR lists).
- `config/*/run.sh` installs with `pacman` on `main` and `apt` on
  `ubuntu-support`. On a conflict there, keep `apt` and port any package
  change to its Ubuntu name.

**Aliases:**

- `dfs/.aliases` is identical on all three branches, and every change to it
  goes to all three. Put OS-specific aliases behind the `$_os_id` checks in
  "OS SPECIFIC" (`arch`: `main`, `legacy-xorg`; `ubuntu`: `ubuntu-support`)
  and machine-specific ones behind a hostname or path check in "MACHINE
  SPECIFIC".
- `dfs/.aliases_legacy` (`legacy-xorg` only, never elsewhere) holds the old
  Xorg desktop and TU Berlin aliases. `dfs/.aliases` sources it on its last
  line when it exists.

## Editing conventions

- **Color preamble:** the top-level scripts (`dfs.sh`, `cfg.sh`) define
  `RED`/`GRN`/`YLW`/`BLU`/`RST` via `\033[...]` escapes. Preserve this.
- **CLI pattern:** a `case` statement where `-h|--help` calls `help()` and an
  invalid option calls `error()`, `help()`, then `exit 1`. Match it when
  adding options.
- **Symlinks:** always `ln -svf`, never plain `ln -sf`.
- **`dfs/.aliases`:** interactive shell only. Its top guard returns early when
  `CLAUDECODE` or `AI_AGENT` is set, so agents get default commands. Keep the
  guard first. Other shell files that override a standard command (`cat`,
  `ls`, `find`, ...) need it too.
- **`config/**/run.sh`:** runs with its own directory as CWD; don't assume the
  caller's. It `rm -rf`s the target before relinking, so it's safe to re-run.

## Gotchas

- `os/run.sh` is an interactive runbook, not idempotent. Hand-edit each step's
  `local ... = "TODO"` placeholders (partition devices, timezone, hostname)
  before running it.
- `config/waybar/` has no `run.sh`; `config/hypr/run.sh` installs it.
- `dfs/.git-credentials` is a plain template without a secret:
  `[token_key_here]` is a placeholder. Don't flag it as a leaked credential.
