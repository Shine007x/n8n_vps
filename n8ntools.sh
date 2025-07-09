#!/bin/sh
set -e

# Variables
CONTAINER_NAME="n8n_container"

# Update package lists
docker exec -i -u root "$CONTAINER_NAME" apt-get update

# Install Python3, pip, ffmpeg, yt-dlp, curl, git, and build tools
docker exec -i -u root "$CONTAINER_NAME" apt-get install -y python3 python3-pip ffmpeg yt-dlp curl git build-essential

# Upgrade pip to latest version
docker exec -i -u root "$CONTAINER_NAME" pip3 install --upgrade pip

# Install PyTorch (torch, torchvision, torchaudio) required for Whisper
docker exec -i -u root "$CONTAINER_NAME" pip3 install --break-system-packages torch torchvision torchaudio

# Install Whisper and Telethon using pip (with break-system-packages)
docker exec -i -u root "$CONTAINER_NAME" pip3 install --break-system-packages openai-whisper telethon

# Done
echo "🎉 Tools installation completed!"
