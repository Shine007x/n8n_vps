#!/bin/sh
set -e

CONTAINER_NAME="n8n_container"

echo "🔄 Starting installation inside container: $CONTAINER_NAME"

docker exec -i -u root "$CONTAINER_NAME" sh -c "
  apk update && \
  apk add --no-cache python3 py3-pip ffmpeg yt-dlp curl git build-base && \
  pip3 install --upgrade pip && \
  pip3 install --break-system-packages telethon openai-whisper
"

echo "🎉 Installation completed successfully!"
