# syntax=docker/dockerfile:1.7

FROM kasmweb/core-ubuntu-jammy:1.19.0

LABEL org.opencontainers.image.title="Kasm OpenSCAD Workspace" \
      org.opencontainers.image.description="Small Kasm Workspaces desktop image for OpenSCAD parametric CAD." \
      org.opencontainers.image.version="1.0" \
      org.opencontainers.image.source="https://github.com/aiscribe152-hermes/hermes-kasm-workspaces"

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        openscad \
    && mkdir -p /usr/share/applications \
    && printf '%s\n' \
        '[Desktop Entry]' \
        'Type=Application' \
        'Name=OpenSCAD' \
        'Comment=The Programmers Solid 3D CAD Modeller' \
        'Exec=/usr/bin/openscad' \
        'Icon=openscad' \
        'Terminal=false' \
        'Categories=Graphics;Engineering;3DGraphics;' \
        > /usr/share/applications/openscad.desktop \
    && openscad --version \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER kasm-user

WORKDIR /home/kasm-user
