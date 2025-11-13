#!/bin/bash

sudo pacman -S --needed --noconfirm fastfetch imagemagick
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
