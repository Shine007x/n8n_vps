#!/bin/sh
set -e

# Variables
CONTAINER_NAME="n8n-hk8gcc0g8c4koskk4o8gc48g"

# Install ffmpeg
docker exec -i -u root "$CONTAINER_NAME" apk add --update python3 py3-pip gcc python3-dev musl-dev curl ffmpeg

# Install yt-dlp
docker exec -i -u root "$CONTAINER_NAME" apk add yt-dlp

# Install cuffi
docker exec -it -u root "$CONTAINER_NAME" pip install "yt-dlp[default,curl-cffi]" --break-system-packages

# Install Telethon (with break-system-packages)
docker exec -i -u root "$CONTAINER_NAME" pip install --break-system-packages telethon

# Done
echo "🎉 Tools installation completed!"
