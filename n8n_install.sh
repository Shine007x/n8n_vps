#!/bin/bash

# Docker Installation
echo "🚀 Starting Docker installation..."
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install -y docker-ce
echo "✅ Docker installation completed!"

# Creating n8n Data Volume
echo "📂 Creating n8n data volume..."
cd ~
mkdir n8n_data
mkdir n8n_temp
sudo chown -R 1000:1000 n8n_data n8n_temp
sudo chmod -R 755 n8n_data n8n_temp
echo "✅ n8n data volume and n8n_temp directory are ready!"

# Docker Compose Setup
echo "🐳 Setting up Docker Compose..."
wget https://raw.githubusercontent.com/zero2launch/n8n_vps/refs/heads/main/compose.yaml -O compose.yaml
export EXTERNAL_IP=http://"$(hostname -I | cut -f1 -d' ')"
sudo -E docker compose up -d
echo "🎉 Installation complete! Access your service at: $EXTERNAL_IP"
