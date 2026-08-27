# syntax=docker/dockerfile:1.7

FROM kasmweb/core-ubuntu-jammy:1.19.0-rolling-weekly

LABEL org.opencontainers.image.title="Kasm KiCad Workspace" \
      org.opencontainers.image.description="Small Kasm Workspaces desktop image for KiCad 10 PCB design and electronics CAD." \
      org.opencontainers.image.version="1.19.0-rolling-weekly" \
      org.opencontainers.image.source="https://github.com/aiscribe152-hermes/hermes-kasm-workspaces"

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gpg \
    && install -d -m 0755 /etc/apt/keyrings \
    && curl -fsSL 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xFDA854F61C4D0D9572BB95E5245D5502FAD7A805' \
        | gpg --dearmor -o /etc/apt/keyrings/kicad-10.0-releases.gpg \
    && chmod 0644 /etc/apt/keyrings/kicad-10.0-releases.gpg \
    && printf '%s\n' 'deb [signed-by=/etc/apt/keyrings/kicad-10.0-releases.gpg] https://ppa.launchpadcontent.net/kicad/kicad-10.0-releases/ubuntu jammy main' \
        > /etc/apt/sources.list.d/kicad-10.0-releases.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        kicad \
        kicad-footprints \
        kicad-libraries \
        kicad-symbols \
        kicad-templates \
        dbus-x11 \
        libgl1-mesa-dri \
        xdg-utils \
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
    && dpkg-query -W kicad kicad-footprints kicad-libraries kicad-symbols kicad-templates \
    && if command -v kicad-cli >/dev/null 2>&1; then kicad-cli version; fi \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY custom_startup.sh /dockerstartup/custom_startup.sh

RUN chmod 0755 /dockerstartup/custom_startup.sh \
    && bash -n /dockerstartup/custom_startup.sh

# Kasm startup scripts must run as root so they can initialize /home/kasm-user,
# copy the default profile, then drop privileges internally.
USER root

WORKDIR /home/kasm-user
