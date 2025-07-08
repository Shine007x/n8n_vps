#!/bin/bash

echo "🚀 Starting RSSHub Docker installation..."

# Prepare directories
cd ~
mkdir -p rsshub/rsshub_data
sudo chown -R 1000:1000 rsshub
sudo chmod -R 755 rsshub
echo "✅ rsshub directory and its contents are ready!"

# Write Dockerfile to install Chromium
cat > ~/rsshub/Dockerfile <<'EOF'
FROM diygod/rsshub:latest

USER root

RUN apt-get update && apt-get install -y chromium

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

USER node
EOF

echo "📝 Dockerfile with Chromium installation created."

# Write docker-compose.yml
cat > ~/rsshub/compose.yml <<EOF
services:
  svr_rsshub:
    build: .
    container_name: rsshub_container
    environment:
      - NODE_ENV=production
      - CACHE_TYPE=redis
      - REDIS_URL=redis://svr_redis:6379/
      - PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
    ports:
      - "3000:1200"
    volumes:
      - /root/rsshub/rsshub_data:/data
    depends_on:
      - svr_redis
    restart: unless-stopped

  svr_redis:
    image: redis:alpine
    container_name: rsshub_redis
    volumes:
      - /root/rsshub/rsshub_data/redis:/data
    restart: unless-stopped
EOF

echo "📝 Docker Compose file created."

# Start containers with build
cd ~/rsshub
sudo docker compose up -d --build

EXTERNAL_IP=http://"$(hostname -I | cut -f1 -d' ')"
echo "🎉 RSSHub with Chromium is now running at: $EXTERNAL_IP"
echo "🌐 Use Cloudflare Tunnel to map to your domain (e.g., https://rsshub.yourdoamin.com)"
