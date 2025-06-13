#!/bin/bash

echo "🚀 Starting RSSHub Docker installation..."

cd ~
mkdir -p rsshub/rsshub_data
sudo chown -R 1000:1000 rsshub
sudo chmod -R 755 rsshub
echo "✅ rsshub directory and its contents are ready!"

cd ~/rsshub/rsshub_data

cat > compose.yml <<EOF
services:
  svr_rsshub:
    image: diygod/rsshub:latest
    container_name: rsshub_container
    environment:
      - NODE_ENV=production
      - CACHE_TYPE=redis
      - REDIS_URL=redis://svr_redis:6379/
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

sudo docker compose up -d

echo "🎉 RSSHub is now running at: http://localhost:3000"
echo "🌐 Use Cloudflare Tunnel to map to: https://rsshub.shinelab.online"
