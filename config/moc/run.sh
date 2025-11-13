#!/bin/bash

exit
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
rm -rf ~/.moc
ln -svf "$ABSOLUTE_PARENT_PATH" ~/.moc
