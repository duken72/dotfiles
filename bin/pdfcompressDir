#!/bin/bash

# PDF Compression - Directories
readarray -t -d '\n' files < <(fd -e=pdf $@)

for file in $files; do
  pdfcompress $file
done