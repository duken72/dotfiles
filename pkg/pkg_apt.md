# `apt` Packages for Ubuntu 20.04

- `fzf` has to be installed from source
- `git-delta-musl_0.15.1_amd64.deb` to avoid [issue with `glibc`](https://github.com/dandavison/delta/issues/1250)

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
