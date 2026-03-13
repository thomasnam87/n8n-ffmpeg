FROM docker.n8n.io/n8nio/n8n:latest

USER root

RUN apk add --no-cache ffmpeg curl

RUN apk add --no-cache ttf-freefont font-noto

USER node
