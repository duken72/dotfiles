#!/bin/bash

exit
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
rm -rf ~/.config/vale
ln -svf $ABSOLUTE_PARENT_PATH -t ~/.config
