#!/bin/bash

echo "3 args: links, start time point, end time point"
# Download the video from YouTube
yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 $1 -o temp.mp3 &&
    # trim and transform it to MP3
    ffmpeg -ss $2 -to $3 -i temp.mp3 -y -vn -c copy file.mp3 &&
    # Clean up
    rm temp.* && clear && echo "Download mp3 completed."
