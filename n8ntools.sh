#!/bin/sh

# Variables
CONTAINER_NAME="n8n_container"

# Install system packages
docker exec -it -u root "$CONTAINER_NAME" apk add --update python3 py3-pip gcc python3-dev musl-dev curl ffmpeg

# Install yt-dlp
docker exec -it -u root "$CONTAINER_NAME" apk add yt-dlp

# Install Telethon using pip
docker exec -it -u root "$CONTAINER_NAME" pip install telethon
