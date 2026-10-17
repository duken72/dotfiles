# `dotfiles`

My personal `dotfiles` and `configs` for an Arch Linux (Hyprland/HyDE-based)
desktop, with notes and scripts for Ubuntu. There are 2 legacy branches for
Ubuntu and Arch Linux with Xorg/Xfce.

## Table of contents

<!-- vim-markdown-toc GFM -->

* [Screenshots](#screenshots)
* [Branches](#branches)
* [Repository layout](#repository-layout)
* [Packages](#packages)
  * [Install packages and dependencies](#install-packages-and-dependencies)
* [Install `dotfiles` and `configs`](#install-dotfiles-and-configs)
  * [`dfs.sh`](#dfssh)
  * [`cfg.sh`](#cfgsh)
  * [`pkg/`](#pkg)
* [Submodules](#submodules)
* [License](#license)

<!-- vim-markdown-toc -->

---

## Screenshots

For backgrounds, check [Wallpapers](Wallpapers).

---

## Branches

- `main`: the Arch Linux setup.
- `ubuntu-support`: `main` plus Ubuntu-based changes, without the Arch files.
- `legacy-xorg`: frozen snapshot of the earlier Xorg/Xfce+polybar setup.

---

## Repository layout

- `bin/`: Bash scripts for customized usage.
- `config/`: Configs for Linux packages.
- `dfs/`: Dotfiles for Linux packages.
- `pkg/`: Package lists and OS-specific install helpers. Nothing here is symlinked.
- `os/`: Install docs. On `main`, these are `archlinux.md` and `run.sh`, a
  numbered-step Arch bootstrap (`pre_partition`, `format_and_mount_partitions`,
  `installation`, `configure`, `create_user`, `post_installation`), invoked as
  `./run.sh <1-6>`. On `ubuntu-support`, it is `ubuntu.md` only.

---

## Packages

Packages that I currently use at [pkg/pkg_pacman.txt](pkg/pkg_pacman.txt) and
[pkg/pkg_aura.txt](pkg/pkg_aura.txt) (on `main` only)

Some worth-mentioned names:

- Shell: `zsh` with `zsh-autosuggestions`, `zsh-completions`, `powerlevel10k`
- Panel: `waybar`
- App launcher: `rofi`
- Browser: `brave`
- `eza`, as replacement for `ls`, also `ranger`
- Media player: `mpd`, `mpv`
- `fd`, `fzf` replace `find`
- `bat`, replace `less` and `cat`
- `sd`, replace `sed`
- `ripgrep`, replace `grep`
- `hyprsunset`
- Others: `tty-clock-git`, etc.

### Install packages and dependencies

Arch Linux (on `main`):

```bash
pacman -S --needed - < pkg/pkg_pacman.txt
aura -A - < pkg/pkg_aura.txt
```

Ubuntu (on `ubuntu-support`):

```bash
./pkg/apt_install.sh
```

---

## Install `dotfiles` and `configs`

I'm, actually .. kind of .. proud of my `.aliases`.
Though not much, but I have gone quite a long way, from ground zero.

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

- `./cfg.sh -i` / `-u`: install / uninstall configs. Uninstall is generic: it
  removes any symlink directly under `~/.config`.
- A `run.sh` installs the app's package via `pacman`, resolves its own path
  with `ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))`, then runs
  `rm -rf ~/.config/<name>` followed by
  `ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config`.
- Some scripts gate installation on other conditions. `config/hypr/run.sh`
  (on `main` only) links itself only when `hyprland` is the detected package,
  and `config/nvim/run.sh` branches on Wayland vs. X11 for the clipboard tool
  (`wl-clipboard` vs. `xclip`).
- Some directories under `config/` have no `run.sh` (`eduroam`, `fstab`,
  `grub`, `waybar`). They are reference-only or installed as a side effect of
  another app's `run.sh` (for example, `waybar` via `config/hypr/run.sh`), so
  they are intentionally not auto-installed.

### `pkg/`

The pacman/AUR lists, `pacman_install.sh` and `delta.sh` aren't on
`ubuntu-support`.

- `pkg_pacman.txt`, `pkg_aura.txt` (AUR), `pkg_pacman_python.txt`,
  `pkg_latex.txt`, `pkg_wayland.txt`, and `pkg_xorg.txt` are plain
  package-name lists. They are consumed via stdin, not file arguments:
  `pacman -S --needed - < pkg/pkg_pacman.txt` or
  `aura -A - < pkg/pkg_aura.txt`.
- `delta.sh` diffs the `.bak` snapshot of a package list against the current
  one, to show what changed after an update. The snapshot comes from
  `bin/pkg_backup.sh` or the `pacman`/`pkg-backup` hooks in `dfs/hook/`.
- `Windows/` holds notes and scripts for Windows. The Ubuntu ones
  (`apt_install.sh`, `pkg_apt.md`) sit directly in `pkg/` on `ubuntu-support`
  only.
- `ws.sh` clones my other personal repos into `~/WS`.

---

## Submodules

`.gitmodules` tracks vendored plugin and theme repos: `zsh-autosuggestions`,
`zsh-completions`, `powerlevel10k`, and `fzf-tab` under `dfs/`, and
`ranger_devicons` under `.config/ranger/plugins/`.

- Run `git submodule update --init` after cloning or pulling.
- The update strategy is `--remote --merge`, so
  `git submodule update --remote --merge` pulls upstream changes instead of
  pinning to the recorded commit.

---

## License

See the [MIT LICENSE](LICENSE.md) file for license rights and limitations.
