# AGENTS.md

Guidance for AI coding agents working in this repository. For the overview,
repository layout, install scripts and submodules, read
[README.md](README.md) first.

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Verifying changes](#verifying-changes)
* [Branches](#branches)
* [Editing conventions](#editing-conventions)
* [Gotchas](#gotchas)

<!-- vim-markdown-toc -->

## Verifying changes

There is no build, lint, or test suite. "Correctness" means the shell scripts
run cleanly and symlinks land where the corresponding `run.sh`, `dfs.sh`, or
`cfg.sh` says they should.

## Branches

The repo has two active long-lived branches, `main` and `ubuntu-support`, plus
one frozen legacy branch, `legacy-xorg`:

- `ubuntu-support`: `main` plus Ubuntu-specific changes only. Examples are
  workarounds for older package versions (such as pinning `nvim-treesitter` for
  an older nvim), fixes for terminals used on Ubuntu (Terminator, Windows
  Terminal), and aliases that differ on Ubuntu.
- `legacy-xorg`: frozen snapshot of the earlier Xorg/Xfce+polybar setup, taken
  at the last commit before the switch to Wayland/Hyprland (`2db86c2`), with
  `config/emptty` and `config/kitty` removed afterwards. Don't sync new
  features or other changes to or from it; only bug fixes go to it (see
  below). Don't push to it unless asked. It is the only branch that
  keeps `config/conky`, `config/htop`, `config/moc`, `config/neofetch`,
  `config/vis`, `config/vscode`, `config/logitech.md`, `config/NetworkManager`,
  `config/openvpn` and `config/pulseaudio-ctl`, and the scripts
  `bin/imgcompress.sh`, `bin/imgcompressDir.sh`, `bin/pdfcompress.sh`,
  `bin/pdfcompressDir.sh`, `bin/vidcompress.sh`, `bin/vidcompressDir.sh`,
  `bin/renameSong.sh` and `os/test.sh`, and the dotfiles `dfs/.pinerc` and
  `dfs/ipython/`. In `dfs/.aliases`, it is also the only branch that keeps
  the TU Berlin block (`tuvpn`, `tum`, `mnas`, `mafs`, `nas*`, `afs*`), the
  `boris` and SVN aliases next to it, the TU Berlin workspace aliases `phd`,
  `par` and `aicon`, the OSD `vc` alias with the
  `export OS=...` line it needs, `FCI_IP`, the `steamid` function, and the
  `mocp`, `polybar` and `neofetch` aliases.

Where each kind of change goes:

- **Bug fixes:** fix the bug on all three branches (`main`, `ubuntu-support`
  and `legacy-xorg`) wherever the buggy code exists, for example by
  cherry-picking the fix. Don't leave a known bug on any branch.
- **New features and other changes:** keep them on `main` and
  `ubuntu-support` only, as described below. Never add them to `legacy-xorg`.
- **Branch-specific changes:** whenever a request leads to a change that
  applies to only some branches (something kept, moved or deleted on one
  branch only), update this file in the same piece of work to record it, so
  that the lists of what lives where stay complete. Keep this file identical
  on all three branches.

Keep `main` and `ubuntu-support` in sync:

- When you make a change on one branch that isn't Ubuntu-specific, bring the
  same change to the other branch (cherry-pick it, or merge `main` into
  `ubuntu-support`).
- Ubuntu-specific changes stay on `ubuntu-support` only.
- Some Ubuntu-only files were deleted from `main` but must stay on
  `ubuntu-support`: `os/ubuntu.md`, and `pkg/apt_install.sh` and
  `pkg/pkg_apt.md` (in `pkg/Ubuntu/` on `main` before they were deleted).
  When merging `main` into `ubuntu-support`, don't let those deletions
  through.
- Some Arch-only files and folders were deleted from `ubuntu-support` and exist
  on `main` only. When merging `main` into `ubuntu-support`, keep them
  deleted, and resolve modify/delete conflicts on them by deleting:
  - `config/cava`, `config/emptty`, `config/grub`, `config/hypr`,
    `config/waybar` and `config/wofi`.
  - `bin/pkg_backup.sh`, `bin/pkg_backup_pre.sh`, `bin/revert-updates.sh` and
    `dfs/hook/` (pacman hooks).
  - `os/archlinux.md` and `os/run.sh`.
  - `pkg/delta.sh`, `pkg/pacman_install.sh` and the pacman/AUR package lists
    `pkg/pkg_*.txt`.
- The `config/*/run.sh` scripts install packages with `pacman` on `main` and
  with `apt` on `ubuntu-support`. When merging `main` into `ubuntu-support`
  causes a conflict on that install line, keep the `apt` line, and port any
  package change to its Ubuntu name.
- `dfs/.aliases` has an OS-specific block that differs by branch: the `apt`
  aliases on `ubuntu-support` and the `pacman`/`aura` aliases on `main`. When
  merging `main` into `ubuntu-support` causes a conflict there, keep the `apt`
  block and delete the `pacman` block.
- `dfs/.aliases` on `ubuntu-support` has no IBUS Unikey and Alsa mixer block
  (`ibus-daemon-start`, `ibus-set-keyboard`, `vnk`, `dek`, `enk`, `ik`,
  `usound`, `dsound`); it stays on `main`. When merging `main` into
  `ubuntu-support` causes a conflict there, keep the block deleted.
- `dfs/.aliases` aliases `cat` to `bat` on `main` and `legacy-xorg`, and to
  `batcat` on `ubuntu-support` (Ubuntu's name for `bat`). When merging `main`
  into `ubuntu-support` causes a conflict on that line, keep `batcat`.
- When you push one branch, push the other one too, so that both remotes stay
  current.

## Editing conventions

- **Color preamble:** all top-level `.sh` scripts (`dfs.sh`, `cfg.sh`) define
  `RED`/`GRN`/`YLW`/`BLU`/`RST` via `\033[...]` escapes. Preserve this.
- **CLI pattern:** use a `case` statement where `-h|--help` calls `help()`
  and an invalid option calls `error()`, then `help()`, then `exit 1`. Match
  this when adding options.
- **Symlinks:** always use `ln -svf` (verbose, force), never plain `ln -sf`.
- **`dfs/.aliases`:** for the user's interactive shell only. A guard at its top
  returns early when `CLAUDECODE` or `AI_AGENT` is set, so AI agents get the
  default commands. Keep that guard at the top, and put new aliases below it.
  Any other shell file that overrides a standard command (such as `cat`, `ls`
  or `find`) needs the same guard.
- **`config/**/run.sh`:** Scripts run with their own directory as CWD, so do
  not assume the caller's CWD. They `rm -rf` the existing target before
  relinking, so they are safe to re-run.

## Gotchas

- `os/run.sh` is an interactive runbook, not an idempotent script. Steps
  contain `local ... = "TODO"` placeholders (partition devices, timezone,
  hostname) that must be hand-edited before running that step.
- `config/waybar/` has no `run.sh`; it is installed by `config/hypr/run.sh`.
