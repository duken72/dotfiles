#!/bin/bash

exit
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
sudo ln -svf $ABSOLUTE_PARENT_PATH -t /usr/share/themes
