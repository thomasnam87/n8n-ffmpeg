FROM n8nio/n8n:latest

USER root

# 1. Cài curl và xz để tải file (dùng apk nếu base là alpine, nhưng n8n official thường base trên debian/node)
#    Tuy nhiên, image n8n rất tối giản. Ta sẽ thử dùng wget có sẵn hoặc curl static.
#    Cách an toàn nhất: dùng image `alpine` để tải, sau đó COPY sang.

# Stage 1: Downloader (dùng Alpine để tải cho dễ)
FROM alpine:latest as downloader
RUN apk add --no-cache curl xz tar
WORKDIR /tmp
# Tải FFmpeg static build (John Van Sickle)
RUN curl -L https://johnvansickle.com/releases/ffmpeg-release-amd64-static.tar.xz -o ffmpeg.tar.xz
RUN tar xf ffmpeg.tar.xz
RUN mv ffmpeg-*-amd64-static/ffmpeg /ffmpeg
RUN mv ffmpeg-*-amd64-static/ffprobe /ffprobe

# Stage 2: Image chính
FROM n8nio/n8n:latest

USER root

# Copy file binary static từ stage 1
COPY --from=downloader /ffmpeg /usr/local/bin/ffmpeg
COPY --from=downloader /ffprobe /usr/local/bin/ffprobe

# Cấp quyền thực thi
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe

USER node
