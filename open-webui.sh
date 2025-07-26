#!/bin/bash

echo "🚀 Starting Open WebUI Docker Compose setup..."

# Step 1: Create working directory
cd ~
mkdir -p open-webui
echo "📁 Created ~/open-webui directory."

# Step 2: Write docker-compose.yml
cat > ~/open-webui/docker-compose.yml <<EOF
services:
  openwebui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    ports:
      - "3010:8010"
    volumes:
      - open-webui:/app/backend/data
    restart: unless-stopped

volumes:
  open-webui:
EOF

echo "📝 Created docker-compose.yml with official settings."

# Step 3: Start the container
cd ~/open-webui
docker compose up -d

# Step 4: Show local access info
IP="http://$(hostname -I | cut -d' ' -f1)"
echo ""
echo "✅ Open WebUI is now running!"
echo "🌐 Access it at: $IP:3010"
echo "🌐 Use Cloudflare Tunnel to map to your domain (e.g., https://swntts.yourdomain.com)"
