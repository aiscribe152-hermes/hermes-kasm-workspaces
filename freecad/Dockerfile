# syntax=docker/dockerfile:1.7

FROM kasmweb/core-ubuntu-jammy:1.19.0

LABEL org.opencontainers.image.title="Kasm FreeCAD Workspace" \
      org.opencontainers.image.description="Small Kasm Workspaces desktop image for FreeCAD using the upstream FreeCAD AppImage." \
      org.opencontainers.image.version="1.1" \
      org.opencontainers.image.source="https://github.com/aiscribe152-hermes/hermes-kasm-workspaces"

USER root

ENV DEBIAN_FRONTEND=noninteractive \
    APPIMAGE_EXTRACT_AND_RUN=1

ARG FREECAD_VERSION=1.1.1
ARG FREECAD_APPIMAGE_URL=https://github.com/FreeCAD/FreeCAD/releases/download/${FREECAD_VERSION}/FreeCAD_${FREECAD_VERSION}-Linux-x86_64-py311.AppImage

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libfuse2 \
        libxcb-cursor0 \
    && mkdir -p /opt/freecad \
    && curl -fL "${FREECAD_APPIMAGE_URL}" -o /opt/freecad/FreeCAD.AppImage \
    && chmod 0755 /opt/freecad/FreeCAD.AppImage \
    && printf '%s\n' '#!/usr/bin/env bash' 'export APPIMAGE_EXTRACT_AND_RUN=1' 'exec /opt/freecad/FreeCAD.AppImage "$@"' > /usr/local/bin/freecad \
    && printf '%s\n' '#!/usr/bin/env bash' 'export APPIMAGE_EXTRACT_AND_RUN=1' 'exec /opt/freecad/FreeCAD.AppImage "$@"' > /usr/local/bin/FreeCAD \
    && printf '%s\n' '#!/usr/bin/env bash' 'export APPIMAGE_EXTRACT_AND_RUN=1' 'exec /opt/freecad/FreeCAD.AppImage "$@"' > /usr/local/bin/freecadcmd \
    && chmod 0755 /usr/local/bin/freecad /usr/local/bin/FreeCAD /usr/local/bin/freecadcmd \
    && mkdir -p /usr/share/applications \
    && printf '%s\n' \
        '[Desktop Entry]' \
        'Type=Application' \
        'Name=FreeCAD' \
        'Comment=Parametric 3D modeler' \
        'Exec=/usr/local/bin/freecad' \
        'Icon=freecad' \
        'Terminal=false' \
        'Categories=Graphics;Engineering;3DGraphics;' \
        > /usr/share/applications/freecad.desktop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY custom_startup.sh /dockerstartup/custom_startup.sh

RUN chmod 0755 /dockerstartup/custom_startup.sh \
    && bash -n /dockerstartup/custom_startup.sh

USER kasm-user

WORKDIR /home/kasm-user
