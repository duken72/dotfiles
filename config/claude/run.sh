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
for D in ~/.claude ~/.claude-account2; do
    [ "$D" = ~/.claude ] || [ -d "$D" ] || continue
    mkdir -p "$D"
    ln -svf $ABSOLUTE_PARENT_PATH/{CLAUDE.md,pr-template.md,brave-mcp.json,brave-live-mcp.json,statusline.sh} -t "$D"
    ln -svfn $ABSOLUTE_PARENT_PATH/commands "$D"/commands
    ln -svfn $ABSOLUTE_PARENT_PATH/rules "$D"/rules
    mkdir -p "$D"/skills
    for s in "$ABSOLUTE_PARENT_PATH"/skills/*/; do ln -svfn "${s%/}" "$D"/skills/; done
    # Private project notes (local.md and the files it points to), if present
    ls $(dirname $PRIVATE_SETTINGS)/*.md &>/dev/null && ln -svf $(dirname $PRIVATE_SETTINGS)/*.md -t "$D"
    if [ -f $PRIVATE_SETTINGS ]; then
        ln -svf $PRIVATE_SETTINGS "$D"/settings.json
    else
        [ -L "$D"/settings.json ] && rm "$D"/settings.json
        cp -nv $ABSOLUTE_PARENT_PATH/settings.json "$D"/settings.json
    fi
done
