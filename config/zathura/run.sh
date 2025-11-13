#!/bin/bash

sudo pacman -S --needed --noconfirm zathura zathura-pdf-mupdf
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
