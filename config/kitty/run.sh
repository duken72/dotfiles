#!/bin/bash

sudo pacman -S --needed --noconfirm kitty
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
rm -rf ~/.config/kitty
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
