#!/bin/bash

echo "🚀 Starting openai-edge-tts Docker installation..."

# Prepare directory
cd ~
mkdir -p openai-edge-tts
echo "✅ openai-edge-tts directory is ready!"

# Write compose.yml
cat > ~/openai-edge-tts/compose.yml <<EOF
services:
  openai-edge-tts:
    image: travisvn/openai-edge-tts:latest
    container_name: openai-edge-tts_container
    ports:
      - "5050:5050"
    environment:
      - API_KEY=kokoshine
    restart: unless-stopped
EOF

echo "📝 Docker Compose file created."

# Start container
cd ~/openai-edge-tts
sudo docker compose up -d

EXTERNAL_IP="http://$(hostname -I | cut -f1 -d' ')"
echo "🎉 openai-edge-tts is now running at: $EXTERNAL_IP:5050"
echo "🌐 Use Cloudflare Tunnel to map to your domain (e.g., https://edge-tts.yourdomain.com)"
echo "🌐 Send requests to /v1/audio/speech endpoint on this address."
