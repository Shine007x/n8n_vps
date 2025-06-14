#!/bin/bash

echo "🟢 Updating n8n image..."
sudo -E docker pull n8nio/n8n
echo "✅ Updated."

# Stop Docker Compose
echo "🟢 Stopping Docker Compose..."
sudo -E docker compose down
echo "🔴 Docker Compose stopped."

read -p "Enter Your Ngrok Domain (without https://): " domain
export EXTERNAL_IP="https://$domain"

# Set Domain as External IP
export EXTERNAL_IP="https://$domain"
echo "✅ URL connected: $EXTERNAL_IP"

# Start Docker Compose
echo "🟢 Starting Docker Compose..."
sudo -E docker compose up -d
sleep 5

echo "🎉 Update complete!"
