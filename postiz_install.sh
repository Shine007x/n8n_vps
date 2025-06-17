#!/bin/bash

echo "📂 Setting up Postiz directories and volumes..."

docker volume create postgres-volume >/dev/null 2>&1
docker volume create postiz-redis-data >/dev/null 2>&1
docker volume create postiz-config >/dev/null 2>&1
docker volume create postiz-uploads >/dev/null 2>&1

echo "✅ Volumes are ready!"

echo "📄 Writing docker-compose.yml..."

cat > docker-compose.yml <<'EOF'
version: "3.9"

services:
  postiz:
    image: ghcr.io/gitroomhq/postiz-app:latest
    container_name: postiz
    restart: always
    environment:
      MAIN_URL: "https://postiz.shinewanna.com"
      FRONTEND_URL: "https://postiz.shinewanna.com"
      NEXT_PUBLIC_BACKEND_URL: "https://postiz.shinewanna.com/api"
      JWT_SECRET: "random-string-please-change"
      DATABASE_URL: "postgresql://postiz-user:postiz-password@postiz-postgres:5432/postiz-db-local"
      REDIS_URL: "redis://postiz-redis:6379"
      BACKEND_INTERNAL_URL: "http://localhost:3000"
      IS_GENERAL: "true"
      DISABLE_REGISTRATION: "false"
      STORAGE_PROVIDER: "local"
      UPLOAD_DIRECTORY: "/uploads"
      NEXT_PUBLIC_UPLOAD_DIRECTORY: "/uploads"
    volumes:
      - postiz-config:/config/
      - postiz-uploads:/uploads/
    ports:
      - 5000:5000
    networks:
      - postiz-network
    depends_on:
      postiz-postgres:
        condition: service_healthy
      postiz-redis:
        condition: service_healthy

  postiz-postgres:
    image: postgres:17-alpine
    container_name: postiz-postgres
    restart: always
    environment:
      POSTGRES_PASSWORD: postiz-password
      POSTGRES_USER: postiz-user
      POSTGRES_DB: postiz-db-local
    volumes:
      - postgres-volume:/var/lib/postgresql/data
    networks:
      - postiz-network
    healthcheck:
      test: pg_isready -U postiz-user -d postiz-db-local
      interval: 10s
      timeout: 3s
      retries: 3

  postiz-redis:
    image: redis:7.2
    container_name: postiz-redis
    restart: always
    healthcheck:
      test: redis-cli ping
      interval: 10s
      timeout: 3s
      retries: 3
    volumes:
      - postiz-redis-data:/data
    networks:
      - postiz-network

volumes:
  postgres-volume:
    external: false
  postiz-redis-data:
    external: false
  postiz-config:
    external: false
  postiz-uploads:
    external: false

networks:
  postiz-network:
    external: false
EOF

echo "✅ docker-compose.yml created!"

echo "🚀 Starting Postiz services..."
docker compose up -d

EXTERNAL_IP="http://$(hostname -I | cut -f1 -d' ')"
echo "🎉 Postiz is now running at: $EXTERNAL_IP:5000"
echo "🌐 Use Cloudflare Tunnel to map to your domain (e.g., https://postiz.shinewanna.com)"
