#!/bin/bash

sudo apt install -y fastfetch imagemagick
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
rm -rf ~/.config/fastfetch
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
