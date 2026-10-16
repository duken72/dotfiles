# AGENTS.md

Guidance for AI coding agents working in this repository.

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Overview](#overview)
* [Branches](#branches)
* [Repository layout](#repository-layout)
* [Install model](#install-model)
  * [`dfs.sh`](#dfssh)
  * [`cfg.sh`](#cfgsh)
  * [`pkg/`](#pkg)
* [Submodules](#submodules)
* [Editing conventions](#editing-conventions)
* [Gotchas](#gotchas)

<!-- vim-markdown-toc -->

## Overview

Personal dotfiles and configs for an Arch Linux (Hyprland/HyDE-based) desktop,
with legacy notes and scripts for Ubuntu. The prior Xorg/Xfce+polybar configs
live only on the `legacy-xorg` branch (see [Branches](#branches)).

There is no build, lint, or test suite. "Correctness" means the shell scripts
run cleanly and symlinks land where the corresponding `run.sh`, `dfs.sh`, or
`cfg.sh` says they should.

## Branches

The repo has two active long-lived branches, plus one frozen legacy branch:

- `main`: the Arch Linux setup.
- `ubuntu-support`: `main` plus Ubuntu-specific changes only. Examples are
  workarounds for older package versions (such as pinning `nvim-treesitter` for
  an older nvim), fixes for terminals used on Ubuntu (Terminator, Windows
  Terminal), and aliases that differ on Ubuntu.
- `legacy-xorg`: frozen snapshot of the earlier Xorg/Xfce+polybar setup, taken
  at the last commit before the switch to Wayland/Hyprland (`2db86c2`). Don't
  sync changes to or from it, and don't push to it unless asked.

Keep `main` and `ubuntu-support` in sync:

- When you make a change on one branch that isn't Ubuntu-specific, bring the
  same change to the other branch (cherry-pick it, or merge `main` into
  `ubuntu-support`).
- Ubuntu-specific changes stay on `ubuntu-support` only.
- Some Ubuntu-only files, such as `os/ubuntu.md`, were deleted from `main` but
  must stay on `ubuntu-support`. When merging `main` into `ubuntu-support`,
  don't let those deletions through.
- When you push one branch, push the other one too, so that both remotes stay
  current.

## Repository layout

- `bin/`: Bash scripts for customized usage.
- `config/`: Configs for Linux packages.
- `dfs/`: Dotfiles for Linux packages.
- `pkg/`: Package lists and OS-specific install helpers. Nothing here is
  symlinked.
- `os/`: Narrative install docs (`archlinux.md`, plus `ubuntu.md` on
  `ubuntu-support` only) and `run.sh`, a
  numbered-step Arch bootstrap (`pre_partition`, `format_and_mount_partitions`,
  `installation`, `configure`, `create_user`, `post_installation`), invoked as
  `./run.sh <1-6>`.

## Install model

There are three independent install mechanisms, each with its own script and
its own set of managed paths.

### `dfs.sh`

Symlinks top-level home dotfiles (`.zshrc`, `.bashrc`, `.gitconfig`, `.vimrc`,
`.p10k.zsh`, `.zsh`, `.powerlevel10k`, `.clang-format`, etc.) from `dfs/` into
`~`. Also symlinks `bin/*` into `/usr/local/bin` (requires sudo).

- `./dfs.sh -i` / `-u`: install / uninstall dotfiles.
- `./dfs.sh -ib` / `-ub`: install / uninstall binaries.
- The managed dotfiles are a hardcoded `DOTFILES=(...)` array at the top of
  `dfs.sh`. Add new top-level dotfiles there, not just in `dfs/`.

### `cfg.sh`

Installs app configs from `config/<name>/` into `~/.config`. It discovers every
`config/**/run.sh` and runs each in its own directory
(`cd "$(dirname "$script")" && ./run.sh`). There is no central list to edit:
to add a managed app, create `config/<name>/run.sh`.

- Uninstall (`cfg.sh -u`) is generic: it removes any symlink directly under
  `~/.config`.
- A `run.sh` installs the app's package via `pacman`, resolves its own path
  with `ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))`, then runs
  `rm -rf ~/.config/<name>` followed by
  `ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config`.
- Some scripts gate installation on other conditions. `config/hypr/run.sh`
  only links itself when `hyprland` is the detected package, and
  `config/nvim/run.sh` branches on Wayland vs. X11 for the clipboard tool
  (`wl-clipboard` vs. `xclip`).
- Some directories under `config/` have no `run.sh` (`conky`, `eduroam`,
  `fstab`, `grub`, `htop`, `vscode`, `waybar`). They are reference-only or
  installed as a side effect of another app's `run.sh` (for example, `waybar`
  via `config/hypr/run.sh`), so they are intentionally not auto-installed.

### `pkg/`

- `pkg_pacman.txt`, `pkg_aura.txt` (AUR), `pkg_pacman_python.txt`,
  `pkg_latex.txt`, `pkg_wayland.txt`, and `pkg_xorg.txt` are plain
  package-name lists. They are consumed via stdin, not file arguments:
  `pacman -S --needed - < pkg/pkg_pacman.txt` or
  `aura -A - < pkg/pkg_aura.txt`.
- `delta.sh` diffs the `.bak` snapshot of a package list against the current
  one, to show what changed after an update. The snapshot comes from
  `bin/pkg_backup.sh` or the `pacman`/`pkg-backup` hooks in `dfs/hook/`.
- `Ubuntu/` and `Windows/` hold notes and scripts for those platforms.
- `ws.sh` clones the author's other personal repos into `~/WS`.

## Submodules

`.gitmodules` tracks vendored plugin and theme repos: `zsh-autosuggestions`,
`zsh-completions`, `powerlevel10k`, and `fzf-tab` under `dfs/`, and
`ranger_devicons` under `.config/ranger/plugins/`.

- Run `git submodule update --init` after cloning or pulling.
- The update strategy is `--remote --merge`, so
  `git submodule update --remote --merge` pulls upstream changes instead of
  pinning to the recorded commit.

## Editing conventions

- **Color preamble:** all top-level `.sh` scripts (`dfs.sh`, `cfg.sh`) define
  `RED`/`GRN`/`YLW`/`BLU`/`RST` via `\033[...]` escapes. Preserve this.
- **CLI pattern:** use a `case` statement where `-h|--help` calls `help()`
  and an invalid option calls `error()`, then `help()`, then `exit 1`. Match
  this when adding options.
- **Symlinks:** always use `ln -svf` (verbose, force), never plain `ln -sf`.
- **`config/**/run.sh`:** Scripts run with their own directory as CWD, so do
  not assume the caller's CWD. They `rm -rf` the existing target before
  relinking, so they are safe to re-run.

## Gotchas

- `os/run.sh` is an interactive runbook, not an idempotent script. Steps
  contain `local ... = "TODO"` placeholders (partition devices, timezone,
  hostname) that must be hand-edited before running that step.
- `config/waybar/` has no `run.sh`; it is installed by `config/hypr/run.sh`.
