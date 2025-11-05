#!/bin/bash

# Stop Docker Compose
echo "🟢 Stopping Docker Compose..."
sudo -E docker compose -f ~/n8n/compose.yml down
echo "🔴 Docker Compose stopped."

# Cloudflare Installation
echo "🟢 Setting up Cloudflare Tunnel..."

# Remove existing service
sudo cloudflared service uninstall

# Add cloudflare gpg key
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# Install cloudflared
sudo apt-get update && sudo apt-get install cloudflared
echo "✅ Cloudflare Tunnel installation completed."

# Request Cloudflare Token and Domain
echo "🔴🔴🔴 Please enter your Cloudflare Tunnel Token and Domain:"
read -p "Enter Cloudflare Tunnel Token: " token
read -p "Enter Cloudflare Tunnel Domain (without https://): " domain

# ✅ Extract token if full command is pasted
token=$(echo "$token" | grep -oP '(?<=--token )\S+' || echo "$token")

# Install Cloudflare Tunnel as a service using the entered token
sudo cloudflared service install "$token"
echo "✅ Cloudflare Tunnel service installed and running."

# Wait for Cloudflare to initialize
echo "🔴🔴🔴 Waiting for Cloudflare Tunnel to initialize..."
sleep 8

# Set Domain as External IP
export EXTERNAL_IP="https://$domain"
echo "✅ Cloudflare URL obtained: $EXTERNAL_IP"

# Start Docker Compose
echo "🟢 Starting Docker Compose..."
sudo -E docker compose -f ~/n8n/compose.yml up -d

LOCAL_IP=http://"$(hostname -I | cut -f1 -d' ')"
echo "🔴 All done! Use Cloudflare Tunnel ($domain) to map to your Local Host ($LOCAL_IP:80)"
