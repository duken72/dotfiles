#!/bin/bash

# Questionable: vale shfmt glow
sudo pacman -S --needed --noconfirm neovim npm luarocks \
    tree-sitter-bash tree-sitter-cli tree-sitter-python shfmt
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
