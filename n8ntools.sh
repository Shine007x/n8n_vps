#!/bin/sh
set -e

# Set your container name
CONTAINER_NAME="n8n_container"

# Run all installation steps inside the container
docker exec -i -u root "$CONTAINER_NAME" bash -c "
  # Update package list
  apt-get update

  # Install Python 3 and pip
  apt-get install -y python3 python3-pip

  # Install ffmpeg (needed for audio/video processing)
  apt-get install -y ffmpeg

  # Install yt-dlp (to download videos from YouTube, TikTok, etc.)
  apt-get install -y yt-dlp

  # Install curl and git (general-purpose tools)
  apt-get install -y curl git

  # Install Python packages:
  # - telethon: for Telegram automation
  # - torch: required for Whisper
  # - openai-whisper: speech-to-text model
  pip3 install --break-system-packages telethon torch torchvision torchaudio openai-whisper
"

# Done
echo "🎉 Tools installation completed!"
