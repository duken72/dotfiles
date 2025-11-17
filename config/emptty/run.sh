#!/bin/bash

# Config emptty display manager if using Wayland & Hyprland
if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
    sudo pacman -S --needed --noconfirm emptty
    sudo rm -rf /etc/emptty
    sudo ln -svf ~/.dotfiles/config/emptty -t /etc

    sudo rm /usr/share/wayland-sessions/*.desktop
    sudo ln -svf ~/.dotfiles/config/emptty/*.desktop -t /usr/share/wayland-sessions
fi
