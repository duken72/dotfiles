#!/bin/bash

# ueberzugpp (image previews) has no package in the Ubuntu repos: pkg/apt_install.sh installs it
sudo apt install -y ranger docx2txt ffmpegthumbnailer ffmpeg atool pipx
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
rm -rf ~/.config/ranger
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config

# Install nbread to preview python notebook with ranger
pipx list | grep nbread
if [ $? -eq 0 ]; then
    echo "Already install nbread."
else
    pipx install git+https://github.com/tnwei/nbread
fi
