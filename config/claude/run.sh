#!/bin/bash

# ~/.claude also holds credentials and session state, so link single files
# into it instead of linking this directory into ~/.config.
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
mkdir -p ~/.claude
ln -svf $ABSOLUTE_PARENT_PATH/CLAUDE.md -t ~/.claude

# Claude Code rewrites settings.json and adds machine-specific entries to it:
# copy it once as a starting point, never link or overwrite it.
[ -e ~/.claude/settings.json ] || cp -v $ABSOLUTE_PARENT_PATH/settings.json ~/.claude/
