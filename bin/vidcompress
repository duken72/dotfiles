#!/bin/bash

# video compression - Single file
file="${1%.*}"-cp."${1##*.}"
ffmpeg -i "$1" -vcodec libx265 -crf 28 "$file" && mv -f "$file" "$1"