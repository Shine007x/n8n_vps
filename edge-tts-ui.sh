#!/bin/bash

echo "🚀 Starting Edge TTS Web Interface Docker installation..."

# Prepare directory
cd ~
mkdir -p edge-tts-web
cd edge-tts-web

# Clone the GitHub repo
if [ ! -d "edge-tts-web-interface" ]; then
  git clone https://github.com/shuo0261/edge-tts-web-interface.git
  echo "✅ Repository cloned."
else
  echo "🔁 Repository already exists, skipping clone."
fi

cd edge-tts-web-interface

# Build the Docker image
docker build -t edge-tts-web .
echo "🐳 Docker image built: edge-tts-web"

# Stop and remove existing container if any
docker rm -f edge-tts-web >/dev/null 2>&1

# Run container (no volume)
docker run -d \
  -p 2024:2024 \
  --name edge-tts-web \
  edge-tts-web

EXTERNAL_IP="http://$(hostname -I | cut -f1 -d' ')"
echo "🎉 Edge TTS Web UI is now running at: $EXTERNAL_IP:2024"
