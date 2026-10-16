# Packages for `Ubuntu 20.04`

`apt` packages:

- install `fzf` from source
- use `git-delta-musl_0.15.1_amd64.deb` to avoid [issue with `glibc`](https://github.com/dandavison/delta/issues/1250)
- install `neovim` using `AppImage`, with `npm` and `python3.8-venv`

```txt
tmux
fd-find
brave-browser
tree
slack
ranger
```

```bash
comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)
apt-cache madison zsh
```
