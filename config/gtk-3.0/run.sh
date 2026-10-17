#!/bin/bash

ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
rm -rf ~/.config/gtk-3.0
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
