#!/bin/bash

# Stop Docker Compose
echo "🟢 Stopping Docker Compose..."
sudo -E docker compose down
echo "🔴 Docker Compose stopped."

# Setup cloudflared
echo "🟢 Installing Cloudflare Tunnel..."
wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin/

# Start cloudflared temporarily to fetch public URL
echo "🌐 Starting Cloudflare Tunnel to fetch URL..."
cloudflared tunnel --url http://localhost:80 > /tmp/cloudflared.log 2>&1 &

# Wait for tunnel to be ready
echo "🔴 Waiting for Cloudflare to initialize..."
sleep 15  # Increased sleep time to ensure tunnel starts

# Fetch public URL from Cloudflare Tunnel API
export EXTERNAL_IP=$(curl -s http://localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')

if [ -n "$EXTERNAL_IP" ]; then
  echo "✅ Cloudflare public URL: $EXTERNAL_IP"
  echo "export EXTERNAL_IP=$EXTERNAL_IP" >> ~/.bashrc
else
  echo "❌ Could not retrieve Cloudflare public URL."
  exit 1
fi

# Kill temporary tunnel (we'll run it as systemd instead)
pkill cloudflared

# Create systemd service to auto-start tunnel
echo "🛠️ Setting up systemd service for cloudflared..."
sudo tee /etc/systemd/system/cloudflared-n8n.service > /dev/null <<EOF
[Unit]
Description=Cloudflare Tunnel for n8n
After=docker.service
Requires=docker.service

[Service]
ExecStart=/usr/local/bin/cloudflared tunnel --url http://localhost:80
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable cloudflared-n8n
sudo systemctl start cloudflared-n8n

# Start Docker Compose again
echo "🟢 Restarting Docker Compose..."
sudo -E docker compose up -d

echo "✅ All done! Your n8n instance is accessible at: $EXTERNAL_IP"
