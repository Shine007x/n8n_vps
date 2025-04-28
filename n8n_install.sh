#!/bin/bash
set -e

# 1) Docker & Compose
echo "🚀 Installing Docker & Compose..."
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install -y docker-ce docker-compose

# 2) Data directories
echo "📂 Creating data dirs..."
cd ~
mkdir -p n8n_data n8n_temp
sudo chown -R 1000:1000 n8n_data n8n_temp
sudo chmod -R 755 n8n_data n8n_temp

# 3) Fetch compose + Dockerfile
echo "📥 Fetching compose & Dockerfile..."
wget https://raw.githubusercontent.com/God109/n8n_vps/refs/heads/main/compose.yaml -O compose.yaml
wget https://raw.githubusercontent.com/God109/n8n_vps/refs/heads/main/Dockerfile -O Dockerfile

# 4) Launch
export EXTERNAL_IP="http://$(hostname -I | awk '{print $1}')"
echo "🐳 Building & starting n8n..."
sudo docker-compose up -d --build

echo "✅ n8n is up at: $EXTERNAL_IP"
