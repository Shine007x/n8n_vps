FROM n8nio/n8n

USER root

# Update the package manager and install required dependencies
RUN apk update && \
    apk add --no-cache \
        python3 \
        py3-pip \
        gcc \
        python3-dev \
        musl-dev \
        curl \
        ffmpeg && \
    pip3 install yt-dlp telethon && \
    apk add --no-cache yt-dlp && \
    rm -rf /var/cache/apk/*  # Clean APK cache

USER node
