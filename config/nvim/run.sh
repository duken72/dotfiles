#!/bin/bash

# Questionable: vale shfmt glow
sudo pacman -S --needed --noconfirm neovim npm luarocks \
    tree-sitter-bash tree-sitter-cli tree-sitter-python shfmt
if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
    sudo pacman -S --needed wl-clipboard
else
    sudo pacman -S --needed xclip
fi
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
