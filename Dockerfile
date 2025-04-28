FROM --platform=linux/amd64 node:18-buster-slim

ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    ffmpeg python3 python3-pip build-essential libffi-dev libssl-dev curl \
    libxml2-dev libxslt-dev zlib1g-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip setuptools wheel

RUN python3 -m pip install yt-dlp telethon

RUN npm install -g n8n

WORKDIR /home/node
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node

USER node

EXPOSE 5678

# No ENTRYPOINT or CMD to avoid auto-start
