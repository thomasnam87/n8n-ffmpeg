# Stage 1: Tải FFmpeg static build trong Alpine
FROM alpine:3.20 AS downloader

RUN wget -q https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz -O /tmp/ffmpeg.tar.xz \
    && cd /tmp \
    && tar xf ffmpeg.tar.xz \
    && mv ffmpeg-*-amd64-static/ffmpeg /ffmpeg \
    && mv ffmpeg-*-amd64-static/ffprobe /ffprobe \
    && chmod +x /ffmpeg /ffprobe

# Stage 2: Image n8n chính
FROM n8nio/n8n:latest

USER root

# Copy static binary vào /usr/bin (chắc chắn nằm trong PATH)
COPY --from=downloader /ffmpeg /usr/bin/ffmpeg
COPY --from=downloader /ffprobe /usr/bin/ffprobe

# ✅ KIỂM TRA NGAY: nếu dòng này fail → build fail → biết ngay lỗi
RUN /usr/bin/ffmpeg -version

USER node
