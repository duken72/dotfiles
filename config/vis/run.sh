#!/bin/bash

exit
if [ -n "$WAYLAND_DISPLAY" ] || [ -S /run/user/$(id -u)/wayland-0 ]; then
    exit
fi
sudo aura -Aax --noconfirm cli-visualizer
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
