#!/bin/bash

# ~/.claude also holds credentials and session state, so link single files
# into it instead of linking this directory into ~/.config.
# settings.json is copied, not linked: Claude Code writes machine-specific
# settings into it (e.g. autoMode with work details), which must stay out of
# this repo. The copy is only made when ~/.claude has none (or only the old
# symlink); copy shared changes back into this repo by hand.

# jq: statusline.sh parses the session JSON with it
sudo pacman -S --needed --noconfirm jq
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
mkdir -p ~/.claude
ln -svf $ABSOLUTE_PARENT_PATH/{CLAUDE.md,pr-template.md,brave-mcp.json,brave-live-mcp.json,statusline.sh} -t ~/.claude
ln -svfn $ABSOLUTE_PARENT_PATH/commands ~/.claude/commands
[ -L ~/.claude/settings.json ] && rm ~/.claude/settings.json
cp -nv $ABSOLUTE_PARENT_PATH/settings.json ~/.claude/settings.json
