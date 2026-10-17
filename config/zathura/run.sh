#!/bin/bash

sudo apt install -y zathura zathura-pdf-mupdf
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
rm -rf ~/.config/zathura
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
