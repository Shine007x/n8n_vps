#!/bin/bash

echo "🚀 Starting Docker installation..."
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install -y docker-ce
echo "✅ Docker installation completed!"

echo "📂 Creating n8n data volumes..."
cd ~
mkdir -p n8n/n8n_data n8n/n8n_temp
sudo chown -R 1000:1000 n8n
sudo chmod -R 755 n8n
echo "✅ n8n data volume and n8n_temp directory are ready!"

echo "🐳 Setting up Docker Compose..."
cd ~/n8n
wget https://raw.githubusercontent.com/Shine007x/n8n_vps/refs/heads/main/compose.yml -O compose.yml

EXTERNAL_IP=http://"$(hostname -I | cut -f1 -d' ')"
sudo -E docker compose up -d

echo "🎉 Installation complete! Access your service at: $EXTERNAL_IP:5678"
