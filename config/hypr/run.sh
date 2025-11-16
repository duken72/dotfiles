#!/bin/bash

sudo pacman -S --needed --noconfirm hyprland wlsunset
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config

git clone -b fix/v0.14.0 https://github.com/sejjy/mechabar.git ~/.config/waybar
