# syntax=docker/dockerfile:1.7

FROM kasmweb/desktop:1.19.0

LABEL org.opencontainers.image.title="Hermes Kasm Forge Workspace" \
      org.opencontainers.image.description="Kasm Workspaces desktop image for mechanical/design forge work: OpenSCAD, FreeCAD, Blender, Python, git, curl, jq, and build tools." \
      org.opencontainers.image.source="https://github.com/bboy8012/hermes-kasm-workspaces"

USER root

ENV DEBIAN_FRONTEND=noninteractive

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
        make \
        openscad \
        pkg-config \
        python3 \
        python3-dev \
        python3-pip \
        python3-venv \
    && ln -sf /usr/bin/python3 /usr/local/bin/python \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Kasm desktop images run as kasm-user by convention.
USER kasm-user

WORKDIR /home/kasm-user
