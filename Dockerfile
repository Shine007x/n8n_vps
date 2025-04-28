FROM n8nio/n8n

USER root

# 1) Update apk and install runtime + build deps
# 2) Install ffmpeg
# 3) Install Python3/pip
# 4) Install Rust toolchain & OpenSSL headers so cryptography can build
# 5) pip-install yt-dlp & telethon
# 6) Clean apk cache
RUN apk update && \
    apk add --no-cache \
      ffmpeg \
      python3 \
      py3-pip \
      build-base \
      libffi-dev \
      openssl-dev \
      rust \
      cargo && \
    pip3 install --upgrade pip wheel && \
    pip3 install yt-dlp telethon && \
    rm -rf /var/cache/apk/*

USER node
