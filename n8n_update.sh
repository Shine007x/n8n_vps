#!/bin/bash

echo "🟢 Updating n8n image..."
sudo apt update
sudo -E docker pull n8nio/n8n
echo "✅ Updated."

# Stop Docker Compose
echo "🟢 Stopping Docker Compose..."
sudo -E docker compose -f ~/n8n/compose.yml down
echo "🔴 Docker Compose stopped."

read -p "Enter Ngrok Tunnel Domain (without https://): " domain

# Export EXTERNAL_IP to current shell environment
export EXTERNAL_IP="https://$domain"
echo "✅ URL connected: $EXTERNAL_IP"

# Start Docker Compose — -E preserves exported variables
echo "🟢 Starting Docker Compose..."
sudo -E docker compose -f ~/n8n/compose.yml up -d
sleep 5

echo "🎉 Update complete!"
