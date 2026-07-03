# syntax=docker/dockerfile:1.7

FROM kasmweb/desktop:1.19.0

LABEL org.opencontainers.image.title="Hermes Kasm Forge Workspace" \
      org.opencontainers.image.description="Kasm Workspaces desktop image for mechanical/design forge work: OpenSCAD, FreeCAD, Blender, Bambu Studio, Python, git, curl, jq, and build tools." \
      org.opencontainers.image.source="https://github.com/aiscribe152-hermes/hermes-kasm-workspaces"

USER root

ENV DEBIAN_FRONTEND=noninteractive
ARG BAMBU_STUDIO_VERSION=02.07.01.62
ARG BAMBU_STUDIO_BUILD=20260616195227
ARG BAMBU_STUDIO_APPIMAGE_URL=https://github.com/bambulab/BambuStudio/releases/download/v${BAMBU_STUDIO_VERSION}/BambuStudio_ubuntu22.04-v${BAMBU_STUDIO_VERSION}-${BAMBU_STUDIO_BUILD}.AppImage

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        blender \
        build-essential \
        ca-certificates \
        cmake \
        curl \
        freecad \
        g++ \
        gcc \
        git \
        jq \
        libfuse2 \
        make \
        openscad \
        pkg-config \
        python3 \
        python3-dev \
        python3-pip \
        python3-venv \
    && ln -sf /usr/bin/python3 /usr/local/bin/python \
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
       fi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Kasm desktop images run as kasm-user by convention.
USER kasm-user

WORKDIR /home/kasm-user
