#!/bin/sh
set -e

# Variables
CONTAINER_NAME="n8n_container"

# Update apk
docker exec -i -u root "$CONTAINER_NAME" apk update

# Install python3, pip, gcc, musl-dev, curl, ffmpeg, yt-dlp
docker exec -i -u root "$CONTAINER_NAME" apk add --no-cache python3 py3-pip gcc python3-dev musl-dev curl ffmpeg yt-dlp

# Install Telethon and Whisper Python packages with break-system-packages
docker exec -i -u root "$CONTAINER_NAME" pip3 install --break-system-packages telethon openai-whisper

echo "🎉 Tools installation completed!"
