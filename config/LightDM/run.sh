#!/bin/bash

if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
    exit
fi
if pacman -Q lightdm &>/dev/null; then
    sudo pacman -S --needed --noconfirm lightdm-gtk-greeter accountsservice numlockx
    ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
    sudo cp -v $ABSOLUTE_PARENT_PATH/*.jpg /usr/share/pixmaps
    sudo cp -v $ABSOLUTE_PARENT_PATH/lightdm-gtk-greeter.conf /etc/lightdm
    sudo cp -v $ABSOLUTE_PARENT_PATH/AccountsService/icons/duken72.png /var/lib/AccountsService/icons
    sudo cp -v $ABSOLUTE_PARENT_PATH/AccountsService/users/duken72 /var/lib/AccountsService/users/duken72
fi
