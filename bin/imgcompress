#!/bin/bash

# png compression - Single file
convert "$1" -quality 27% "${1%.*}".jpg
if ! [ "${1##*.}" = "jpg" ]; then
  rm "$1"
fi