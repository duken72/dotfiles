#!/bin/bash

# Questionable: vale shfmt glow
if command -v pacman >/dev/null; then
    sudo pacman -S --needed --noconfirm neovim npm luarocks \
        tree-sitter-bash tree-sitter-cli tree-sitter-python shfmt
    if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
        sudo pacman -S --needed wl-clipboard
    else
        sudo pacman -S --needed xclip
    fi
elif command -v apt >/dev/null; then
    # neovim itself: see pkg/Ubuntu/apt_install.sh (apt's version is too old on 22.04)
    # luarocks + lua headers: mason's luacheck; python3-venv: mason's pip packages
    sudo apt install -y npm luarocks liblua5.3-dev python3-venv build-essential \
        curl unzip ripgrep shfmt xclip
fi
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
