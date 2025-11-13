#!/bin/bash

sudo pacman -S --needed --noconfirm xdg-user-dirs
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH/user-dirs.* -t ~/.config
