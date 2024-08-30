# YouTube-Transcriber-and-Formatter

This project provides a simple bash script to download and format transcripts from YouTube videos.

## Features

- Downloads subtitles from a specified YouTube video
- Converts subtitles to SRT format
- Cleans up the transcript by removing timestamps and unnecessary formatting
- Outputs a clean, readable text file

## Prerequisites

Before you begin, ensure you have the following installed:
- bash
- yt-dlp
- sed

## Usage

1. Clone this repository:

```bash
git clone https://github.com/warezit/YouTube-Transcriber-and-Formatter.git
cd YouTube-Transcriber-and-Formatter
```

2. Make the script executable:

```bash
chmod +x transcribe.sh
```

3. Edit the `VIDEO_URL` variable in `transcribe.sh` to specify your desired YouTube video:

```sh
VIDEO_URL="https://www.youtube.com/watch?v=your_video_id_here"
```

4. Run the script:
```bash
./transcribe.sh
```
5. The cleaned transcript will be saved as `output.txt` in the same directory.

