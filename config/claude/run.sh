#!/bin/bash

# ~/.claude also holds credentials and session state, so link single files
# into it instead of linking this directory into ~/.config.
# settings.json is not linked from this repo: it holds machine-specific
# settings (e.g. autoMode with work details), which must stay out of it.
# If the private copy in PRIVATE_SETTINGS exists, link that. Otherwise copy
# this repo's version, only when ~/.claude has none (or only the old symlink).
# Either way, copy shared changes back into this repo by hand.
PRIVATE_SETTINGS=~/WS/adle-vf/claude/settings.json

# jq: statusline.sh parses the session JSON with it
sudo apt install -y jq
ABSOLUTE_PARENT_PATH=$(realpath $(dirname $BASH_SOURCE))
mkdir -p ~/.claude
ln -svf $ABSOLUTE_PARENT_PATH/{CLAUDE.md,pr-template.md,brave-mcp.json,brave-live-mcp.json,statusline.sh} -t ~/.claude
if [ -f $PRIVATE_SETTINGS ]; then
    ln -svf $PRIVATE_SETTINGS ~/.claude/settings.json
else
    [ -L ~/.claude/settings.json ] && rm ~/.claude/settings.json
    cp -nv $ABSOLUTE_PARENT_PATH/settings.json ~/.claude/settings.json
fi
