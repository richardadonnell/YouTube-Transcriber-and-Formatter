#!/bin/bash

echo "Please enter the YouTube URL:"
read youtube_url

yt-dlp --skip-download --write-subs --write-auto-subs --sub-lang en --sub-format srt --output "transcript.%(ext)s" "$youtube_url" && \
sed -e '/^[0-9][0-9]:[0-9][0-9]:[0-9][0-9],[0-9][0-9][0-9] --> [0-9][0-9]:[0-9][0-9]:[0-9][0-9],[0-9][0-9][0-9]$/d' \
-e '/^[[:digit:]]\+$/d' \
-e 's/<[^>]*>//g' \
-e '/^[[:space:]]*$/d' \
-e ':a;N;$!ba;s/\n/ /g' \
transcript.en.srt > output.txt && \
rm transcript.en.srt

python topic_segment.py

echo "Processing complete. Segmented output saved in segmented_output.txt"
