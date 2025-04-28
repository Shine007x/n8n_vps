RUN apt-get update && \
    apt-get install -y --no-install-recommends --fix-missing \
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
