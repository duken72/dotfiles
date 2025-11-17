#!/bin/bash

# Config polybar and redshift for startup if using xorg & xfce4
if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
    exit
fi
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
