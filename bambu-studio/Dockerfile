# syntax=docker/dockerfile:1.7

FROM kasmweb/core-ubuntu-jammy:1.19.0

LABEL org.opencontainers.image.title="Kasm Bambu Studio Workspace" \
      org.opencontainers.image.description="Small Kasm Workspaces desktop image for Bambu Studio slicing and 3D printing workflows." \
      org.opencontainers.image.version="1.1" \
      org.opencontainers.image.source="https://github.com/aiscribe152-hermes/hermes-kasm-workspaces"

USER root

ENV DEBIAN_FRONTEND=noninteractive

ARG BAMBU_STUDIO_VERSION=02.07.01.62
ARG BAMBU_STUDIO_BUILD=20260616195227
ARG BAMBU_STUDIO_APPIMAGE_URL=https://github.com/bambulab/BambuStudio/releases/download/v${BAMBU_STUDIO_VERSION}/BambuStudio_ubuntu22.04-v${BAMBU_STUDIO_VERSION}-${BAMBU_STUDIO_BUILD}.AppImage

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libfuse2 \
        libwebkit2gtk-4.1-0 \
    && mkdir -p /opt/bambu-studio \
    && curl -fL "${BAMBU_STUDIO_APPIMAGE_URL}" -o /tmp/BambuStudio.AppImage \
    && chmod 0755 /tmp/BambuStudio.AppImage \
    && cd /opt/bambu-studio \
    && /tmp/BambuStudio.AppImage --appimage-extract \
    && rm -f /tmp/BambuStudio.AppImage \
    && printf '%s\n' '#!/usr/bin/env bash' 'exec /opt/bambu-studio/squashfs-root/AppRun "$@"' > /usr/local/bin/bambu-studio \
    && chmod 0755 /usr/local/bin/bambu-studio \
    && if [ -f /opt/bambu-studio/squashfs-root/BambuStudio.desktop ]; then \
          sed 's#^Exec=.*#Exec=/usr/local/bin/bambu-studio#' /opt/bambu-studio/squashfs-root/BambuStudio.desktop > /usr/share/applications/bambu-studio.desktop; \
       else \
          printf '%s\n' \
            '[Desktop Entry]' \
            'Type=Application' \
            'Name=Bambu Studio' \
            'Comment=3D printing slicer' \
            'Exec=/usr/local/bin/bambu-studio' \
            'Icon=bambu-studio' \
            'Terminal=false' \
            'Categories=Graphics;Engineering;3DGraphics;' \
            > /usr/share/applications/bambu-studio.desktop; \
       fi \
    && test -x /usr/local/bin/bambu-studio \
    && test -x /opt/bambu-studio/squashfs-root/AppRun \
    && test -e /usr/lib/x86_64-linux-gnu/libwebkit2gtk-4.1.so.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY custom_startup.sh /dockerstartup/custom_startup.sh

RUN chmod 0755 /dockerstartup/custom_startup.sh \
    && bash -n /dockerstartup/custom_startup.sh

USER kasm-user

WORKDIR /home/kasm-user
