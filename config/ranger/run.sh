#!/bin/bash

# sudo pacman -Sy --needed --noconfirm ranger docx2txt ueberzugpp \
sudo pacman -S --needed --noconfirm ranger docx2txt ueberzug \
    ffmpegthumbnailer ffmpeg atool python-pipx
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config

# Install nbread to preview python notebook with ranger
pipx install git+https://github.com/tnwei/nbread
