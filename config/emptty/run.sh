#!/bin/bash

# Config emptty display manager if using Wayland & Hyprland
if pacman -Q emptty &>/dev/null; then
    sudo rm -rf /etc/emptty
    sudo ln -svf ~/.dotfiles/config/emptty -t /etc

    sudo rm /usr/share/wayland-sessions/*.desktop
    sudo ln -svf ~/.dotfiles/config/emptty/*.desktop -t /usr/share/wayland-sessions
fi
