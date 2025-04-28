FROM node:18-buster-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=1

USER root

# Install system dependencies including build tools and libraries for Python packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    ffmpeg \
    python3 \
    python3-pip \
    build-essential \
    libffi-dev \
    libssl-dev \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Upgrade pip and setuptools first
RUN python3 -m pip install --upgrade pip setuptools wheel

# Install telethon via pip separately
RUN python3 -m pip install telethon

# Download yt-dlp binary directly and make it executable
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && \
    chmod +x /usr/local/bin/yt-dlp

# Install n8n globally
RUN npm install -g n8n

WORKDIR /home/node
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node

USER node

EXPOSE 5678

# No ENTRYPOINT or CMD so container does not start anything by default
