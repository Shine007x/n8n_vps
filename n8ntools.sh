#!/bin/sh
set -e

# Variables
CONTAINER_NAME="n8n_container"

# Install ffmpeg
docker exec -i -u root "$CONTAINER_NAME" apk add --update python3 py3-pip gcc python3-dev musl-dev curl ffmpeg

# Install yt-dlp
docker exec -i -u root "$CONTAINER_NAME" apk add yt-dlp

# Install Telethon and Whisper (with break-system-packages)
docker exec -i -u root "$CONTAINER_NAME" pip install --break-system-packages torch torchvision torchaudio

docker exec -i -u root "$CONTAINER_NAME" pip install --break-system-packages openai-whisper telethon

# Done
echo "🎉 Tools installation completed!"
