#!/bin/bash

# This bash script rename all song in a directory to this format
# <artists names> - <title>.mp3

clear

if ! command -v eyeD3 &> /dev/null; then
    echo "Need to install eyeD3"
    exit 1
fi

for file in ./*.mp3; do
  # echo "FILE: $file"
  str=$(eyeD3 "$file" | grep "title:")
  title=${str/"title: "/}
  # echo "TITLE: $title"
  str=$(eyeD3 "$file" | grep "artist:" | grep -v "album" | grep -v "original")
  artist=${str/"artist: "/}
  # echo "ARTIST: $artist"
  mv "$file" "$artist - $title.mp3"
done
