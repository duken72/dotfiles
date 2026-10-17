#!/bin/bash

sudo pacman -S --needed --noconfirm cava
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
rm -rf ~/.config/cava
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
