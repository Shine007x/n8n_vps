#!/bin/bash

echo "🚀 Starting RSS-Bridge Docker installation..."

# Prepare directories
cd ~
mkdir -p rssbridge/rssbridge_data
sudo chown -R 1000:1000 rssbridge
sudo chmod -R 755 rssbridge
echo "✅ rssbridge directory and its contents are ready!"

# Write docker-compose.yml
cat > ~/rssbridge/compose.yml <<EOF
services:
  rssbridge:
    image: rssbridge/rss-bridge:latest
    container_name: rssbridge_container
    ports:
      - "2000:80"
    volumes:
      - /root/rssbridge/rssbridge_data:/var/www/html/cache
    restart: unless-stopped
EOF

echo "📝 Docker Compose file created."

# Start containers
cd ~/rssbridge
sudo docker compose up -d

EXTERNAL_IP="http://$(hostname -I | cut -f1 -d' ')"
echo "🎉 RSS-Bridge is now running at: $EXTERNAL_IP:2000"
echo "🌐 Use Cloudflare Tunnel to map to your domain (e.g., https://rssbridge.shinelab.online)"
