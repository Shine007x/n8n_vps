FROM n8nio/n8n

USER root

RUN apk update && \
    apk add --no-cache ffmpeg python3 py3-pip && \
    pip3 install yt-dlp telethon && \
    rm -rf /var/cache/apk/*

USER node
