#!/bin/bash

echo "4 args: links, start time point, end time point, filename"
# Download the video from YouTube
yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 $1 -o temp.mp3 &&
	# trim and transform it to MP3
	ffmpeg -ss $2 -to $3 -i temp.mp3 -y -vn -c copy "$4.mp3" &&
	# Clean up
	rm temp.* && clear && echo "Downloaded: $4.mp3"
