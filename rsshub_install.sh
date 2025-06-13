#!/bin/bash

echo "🚀 Starting RSSHub Docker installation..."
# Create data directory like n8n
cd ~
mkdir -p rsshub_data
sudo chown -R 1000:1000 rsshub_data
sudo chmod -R 755 rsshub_data
echo "✅ rsshub_data directory is ready!"

# Write the docker-compose YAML without 'version' field
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
      - /root/rsshub_data:/data
    depends_on:
      - svr_redis
    restart: unless-stopped

  svr_redis:
    image: redis:alpine
    container_name: rsshub_redis
    volumes:
      - /root/rsshub_data/redis:/data
    restart: unless-stopped
EOF

echo "📝 Docker Compose file created."

# Start containers
sudo docker compose up -d
# 🌐 Display local info only
echo "🎉 RSSHub is now running at: http://localhost:3000"
echo "🌐 Use Cloudflare Tunnel to map to: https://rsshub.shinelab.online"
