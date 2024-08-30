#!/bin/bash

# Variables
VIDEO_URL="https://www.youtube.com/watch?v=bKwbFuqt528"
TRANSCRIPT_FILE="transcript.en.srt"
OUTPUT_FILE="output.txt"

# Download subtitles
yt-dlp --skip-download --write-subs --write-auto-subs --sub-lang en \
--sub-format ttml --convert-subs srt \
--output "transcript.%(ext)s" "$VIDEO_URL" || exit 1

# Check if the transcript file exists
if [ ! -f "$TRANSCRIPT_FILE" ]; then
    echo "Error: $TRANSCRIPT_FILE not found"
    exit 1
fi

# Clean up subtitles
sed -i.bak \
-e '/^[0-9][0-9]:[0-9][0-9]:[0-9][0-9].[0-9][0-9][0-9] --> [0-9][0-9]:[0-9][0-9]:[0-9][0-9].[0-9][0-9][0-9]$/d' \
-e '/^[[:digit:]]\{1,3\}$/d' \
-e 's/<[^>]*>//g' \
-e '/^[[:space:]]*$/d' \
"$TRANSCRIPT_FILE" || exit 1

# Remove backup file created by sed
rm "${TRANSCRIPT_FILE}.bak"

# Create final output and remove intermediate file
mv "$TRANSCRIPT_FILE" "$OUTPUT_FILE" || exit 1

echo "Transcript successfully created in $OUTPUT_FILE"