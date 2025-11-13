#!/bin/bash

# Config emptty display manager if using Wayland & Hyprland
if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
    echo "Wayland"
    # TODO
    sudo pacman -S --needed --noconfirm emptty
fi
