#!/bin/bash

if pacman -Q hyprland &>/dev/null; then
    sudo pacman -S --needed --noconfirm wlsunset waybar
    ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
    rm -rf ~/.config/hypr
    ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
    git clone -b fix/v0.14.0 https://github.com/sejjy/mechabar.git ~/.config/waybar
fi
