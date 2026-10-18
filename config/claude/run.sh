#!/bin/bash

# ~/.claude also holds credentials and session state, so link single files
# into it instead of linking this directory into ~/.config.
# Claude Code writes through the settings.json symlink (tested on 2.1.302), so
# plugin and setting changes made in Claude Code land in this repo: commit them
# to share the same plugins across machines.
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
mkdir -p ~/.claude
ln -svf $ABSOLUTE_PARENT_PATH/{CLAUDE.md,pr-template.md,settings.json,brave-mcp.json,brave-live-mcp.json,statusline.sh} -t ~/.claude
