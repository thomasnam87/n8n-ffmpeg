FROM n8nio/n8n:latest

USER root

# Tải bản FFmpeg static build (chạy được trên mọi Linux)
RUN curl -O https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz \
    && tar xvf ffmpeg-release-amd64-static.tar.xz \
    && mv ffmpeg-*-amd64-static/ffmpeg /usr/bin/ffmpeg \
    && mv ffmpeg-*-amd64-static/ffprobe /usr/bin/ffprobe \
    && rm -rf ffmpeg-* \
    && chmod +x /usr/bin/ffmpeg /usr/bin/ffprobe

USER node
