#!/bin/sh
set -e

# Variables
CONTAINER_NAME="n8n_container"

# Update package lists
docker exec -i -u root "$CONTAINER_NAME" apt-get update

# Install ffmpeg and dependencies
docker exec -i -u root "$CONTAINER_NAME" apt-get install -y python3 python3-pip build-essential ffmpeg curl

# Install yt-dlp
docker exec -i -u root "$CONTAINER_NAME" apt-get install -y yt-dlp

# Upgrade pip
docker exec -i -u root "$CONTAINER_NAME" pip3 install --upgrade pip

# Install Telethon and Whisper using pip (with break-system-packages)
docker exec -i -u root "$CONTAINER_NAME" pip3 install --break-system-packages telethon openai-whisper torch torchvision torchaudio

# Done
echo "🎉 Tools installation completed!"
