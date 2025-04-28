# Use Node-18 on Debian-slim instead of Alpine
FROM node:18-buster-slim

# Set environment variables
ENV NODE_ENV=production

# Switch to root to install system packages
USER root

# Install ffmpeg, Python3, pip, yt-dlp & Telethon dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      python3 \
      python3-pip \
      build-essential \
      libffi-dev \
      libssl-dev \
      curl && \
    pip3 install yt-dlp telethon && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install n8n globally
RUN npm install -g n8n

# Create and set working directory
WORKDIR /home/node

# Make sure the user owns their home directory
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/

# Switch to non-root user
USER node

# Expose n8n port
EXPOSE 5678

# Default command
ENTRYPOINT ["n8n"]
CMD ["start"]
