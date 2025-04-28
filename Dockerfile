# Start from the official n8n image
FROM n8nio/n8n:latest

# Install ffmpeg, Python3, pip, and other needed utilities
USER root

RUN apt-get update && apt-get install -y \
    ffmpeg \
    python3 \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install yt-dlp and telethon using pip
RUN pip3 install --no-cache-dir yt-dlp telethon

# Return to default n8n user
USER node

# Expose port (optional, default is 5678)
EXPOSE 5678
