#!/bin/sh
set -e

CONTAINER_NAME="n8n_container"

echo "🔄 Starting installation inside container: $CONTAINER_NAME"

docker exec -i -u root "$CONTAINER_NAME" bash -c "
  apt-get update && \
  apt-get install -y python3 python3-pip ffmpeg yt-dlp curl git build-essential && \
  pip3 install --upgrade pip && \
  pip3 install --break-system-packages torch==1.10.1 torchvision torchaudio && \
  pip3 install --break-system-packages -U openai-whisper telethon
"

echo "🎉 Installation completed successfully!"
