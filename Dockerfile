FROM node:18-buster-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=1

USER root

# Install system dependencies including ffmpeg and build tools
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    ffmpeg \
    python3 \
    python3-pip \
    build-essential \
    libffi-dev \
    libssl-dev \
    curl \
    libxml2-dev \
    libxslt-dev \
    zlib1g-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, wheel
RUN python3 -m pip install --upgrade pip setuptools wheel

# Install yt-dlp and telethon via pip
RUN python3 -m pip install yt-dlp telethon

# Install n8n globally (optional, remove if not needed)
RUN npm install -g n8n

USER node

EXPOSE 5678

# No default command or entrypoint; run what you need at runtime
