#!/bin/bash

# Docker Installation
echo "🚀 Starting Docker installation..."
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install -y docker-ce docker-compose
echo "✅ Docker installation completed!"

# Creating n8n Data Volumes
echo "📂 Creating n8n data volumes..."
cd ~
mkdir -p n8n_data n8n_temp
sudo chown -R 1000:1000 n8n_data n8n_temp
sudo chmod -R 755 n8n_data n8n_temp
echo "✅ n8n data volumes are ready!"

# Docker Compose and Dockerfile Setup
echo "🐳 Setting up Docker Compose and Dockerfile..."
wget https://raw.githubusercontent.com/God109/n8n_vps/main/docker-compose.yml -O docker-compose.yml
wget https://raw.githubusercontent.com/God109/n8n_vps/main/Dockerfile -O Dockerfile

# Set EXTERNAL_IP environment variable
export EXTERNAL_IP=http://"$(hostname -I | awk '{print $1}')"

# Start Docker Compose
sudo -E docker-compose up -d --build
echo "🎉 Installation complete! Access your service at: $EXTERNAL_IP"
