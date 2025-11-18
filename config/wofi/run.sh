#!/bin/bash

# Credit: https://github.com/Firstp1ck/Hyprland-Simple-Setup

sudo pacman -S --needed --noconfirm wofi
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
