#!/bin/bash

echo "🟢 Updating n8n image..."
sudo -E docker pull n8nio/n8n
echo "✅ Updated."

# Stop Docker Compose
echo "🟢 Stopping Docker Compose..."
sudo -E docker compose -f ~/n8n/compose.yml down
echo "🔴 Docker Compose stopped."

read -p "Enter Cloudflare Tunnel Domain (without https://): " domain

# Set Domain as External IP
export EXTERNAL_IP="https://$domain"
echo "✅ URL connected: $EXTERNAL_IP"

# Start Docker Compose with EXTERNAL_IP injected
echo "🟢 Starting Docker Compose..."
sudo -E EXTERNAL_IP="$EXTERNAL_IP" docker compose -f ~/n8n/compose.yml up -d
sleep 5

echo "🎉 Update complete!"
