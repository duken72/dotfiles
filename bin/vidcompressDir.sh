#!/bin/bash

# Video Compression - Directories
for file in *.mp4, *.MP4 *.MOV *.mov; do
  vidcompress $file
done