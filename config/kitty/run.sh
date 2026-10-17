#!/bin/bash

sudo apt install -y kitty
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
rm -rf ~/.config/kitty
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
