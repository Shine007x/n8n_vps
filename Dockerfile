FROM n8nio/n8n

USER root

# Install ffmpeg, python3, and pip
RUN apk update && \
    apk add --no-cache ffmpeg && \
    apk add --no-cache python3 && \
    apk add --no-cache py3-pip

# Install Python packages yt-dlp and telethon
RUN pip3 install yt-dlp telethon

# Clean up the cache
RUN rm -rf /var/cache/apk/*

USER node
