#!/bin/bash

echo "🚀 Starting openai-edge-tts Docker installation..."

# Set your API key here (change this before running)
API_KEY="kokoshine007"

# Prepare directory
cd ~
mkdir -p openai-edge-tts
echo "✅ openai-edge-tts directory created."

# Write compose.yml
cat > ~/openai-edge-tts/compose.yml <<EOF
services:
  openai-edge-tts:
    image: travisvn/openai-edge-tts:latest
    container_name: openai-edge-tts_container
    ports:
      - "5050:5050"
    environment:
      - API_KEY=${API_KEY}
    restart: unless-stopped
EOF

echo "📝 Docker Compose file (compose.yml) created with API_KEY."

# Start container
cd ~/openai-edge-tts
sudo docker compose up -d

# Detect external IP (first IP)
EXTERNAL_IP=$(hostname -I | awk '{print $1}')

echo "🎉 openai-edge-tts is running at: http://$EXTERNAL_IP:5050"
echo "🌐 Send requests to the /v1/audio/speech endpoint on this address."
echo "🔑 Your API_KEY is set to: $API_KEY"
