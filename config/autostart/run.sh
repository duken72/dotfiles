#!/bin/bash

# Config polybar and redshift for startup if using xorg & xfce4
if [ -n "$DISPLAY" ] || [ -S /tmp/.X11-unix/X0 ]; then
    ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
    ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
fi
