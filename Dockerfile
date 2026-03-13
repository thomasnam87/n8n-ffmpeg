# Stage 1: Lấy ffmpeg từ Alpine
FROM alpine:3.20 AS ffmpeg-builder
RUN apk add --no-cache ffmpeg

# Stage 2: Image n8n chính
FROM n8nio/n8n:latest

USER root

# Copy ffmpeg và các thư viện cần thiết từ Alpine
COPY --from=ffmpeg-builder /usr/bin/ffmpeg /usr/bin/ffmpeg
COPY --from=ffmpeg-builder /usr/bin/ffprobe /usr/bin/ffprobe
COPY --from=ffmpeg-builder /usr/lib /usr/lib

USER node
