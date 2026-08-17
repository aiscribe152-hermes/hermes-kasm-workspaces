# syntax=docker/dockerfile:1.7

FROM kasmweb/core-ubuntu-jammy:1.19.0-rolling-weekly

LABEL org.opencontainers.image.title="Kasm KiCad Workspace" \
      org.opencontainers.image.description="Small Kasm Workspaces desktop image for KiCad PCB design and electronics CAD." \
      org.opencontainers.image.version="1.19.0-rolling-weekly" \
      org.opencontainers.image.source="https://github.com/aiscribe152-hermes/hermes-kasm-workspaces"

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        kicad \
        kicad-footprints \
        kicad-symbols \
        kicad-templates \
    && mkdir -p /usr/share/applications \
    && if [ ! -f /usr/share/applications/org.kicad.kicad.desktop ]; then \
          printf '%s\n' \
            '[Desktop Entry]' \
            'Type=Application' \
            'Name=KiCad' \
            'Comment=Electronic schematic and PCB design' \
            'Exec=/usr/bin/kicad' \
            'Icon=kicad' \
            'Terminal=false' \
            'Categories=Development;Engineering;Electronics;' \
            > /usr/share/applications/kicad.desktop; \
       fi \
    && test -x /usr/bin/kicad \
    && dpkg-query -W kicad kicad-footprints kicad-symbols kicad-templates \
    && if command -v kicad-cli >/dev/null 2>&1; then kicad-cli version; fi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY custom_startup.sh /dockerstartup/custom_startup.sh

RUN chmod 0755 /dockerstartup/custom_startup.sh \
    && bash -n /dockerstartup/custom_startup.sh

USER kasm-user

WORKDIR /home/kasm-user
