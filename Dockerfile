FROM node:18-buster-slim

ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      python3 \
      python3-pip \
      build-essential \
      libffi-dev \
      libssl-dev \
      curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install yt-dlp telethon

RUN npm install -g n8n

WORKDIR /home/node
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node

USER node

EXPOSE 5678

# No ENTRYPOINT or CMD defined - container will exit immediately unless you specify a command at runtime
