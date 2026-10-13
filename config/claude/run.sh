#!/bin/bash

# Claude Code keeps its state in ~/.claude, so link only the file, not the folder
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
mkdir -p ~/.claude
ln -svf $ABSOLUTE_PARENT_PATH/CLAUDE.md -t ~/.claude
