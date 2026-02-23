FROM docker.n8n.io/n8nio/n8n:latest

USER root

# Копируем статические ffmpeg/ffprobe (без apk/apt)
COPY --from=mwader/static-ffmpeg:8.0 /ffmpeg /usr/local/bin/ffmpeg
COPY --from=mwader/static-ffmpeg:8.0 /ffprobe /usr/local/bin/ffprobe

# (Опционально, но полезно для субтитров/drawtext)
COPY --from=mwader/static-ffmpeg:8.0 /etc/fonts /etc/fonts
COPY --from=mwader/static-ffmpeg:8.0 /usr/share/fonts /usr/share/fonts

USER node
