#!/bin/bash

ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
sudo ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
