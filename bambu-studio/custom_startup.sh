#!/usr/bin/env bash
set -euo pipefail

LOG_FILE=/tmp/bambu-studio-startup.log
APP_CMD=/usr/local/bin/bambu-studio
APP_MATCH=/opt/bambu-studio/squashfs-root/bin/bambu-studio

configure_default_browser() {
  export HOME="${HOME:-/home/kasm-user}"

  # Persistent Kasm profiles can keep older ~/.config state from a previous
  # image. Refresh the browser handler at every launch so Bambu OAuth opens
  # Chrome instead of failing with no/default browser errors.
  mkdir -p "$HOME/.local/share/applications" "$HOME/.config"

  cat >"$HOME/.local/share/applications/default-browser.desktop" <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Default Browser
Exec=/usr/local/bin/default-browser %u
Icon=google-chrome
Terminal=false
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;
EOF

  cat >"$HOME/.config/mimeapps.list" <<'EOF'
[Default Applications]
x-scheme-handler/http=default-browser.desktop
x-scheme-handler/https=default-browser.desktop
text/html=default-browser.desktop
text/xml=default-browser.desktop
application/xhtml+xml=default-browser.desktop

[Added Associations]
x-scheme-handler/http=default-browser.desktop;
x-scheme-handler/https=default-browser.desktop;
text/html=default-browser.desktop;
EOF

  export BROWSER=/usr/local/bin/default-browser
  command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database "$HOME/.local/share/applications" >/dev/null 2>&1 || true
}

start_bambu_studio() {
  export DISPLAY="${DISPLAY:-:1}"
  export HOME="${HOME:-/home/kasm-user}"
  # Include /etc for xfce4-session; Kasm may source this file into the
  # desktop startup environment.
  export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg:/etc}"
  export SSL_CERT_FILE="${SSL_CERT_FILE:-/etc/ssl/certs/ca-certificates.crt}"
  export SSL_CERT_DIR="${SSL_CERT_DIR:-/etc/ssl/certs}"
  export BROWSER="${BROWSER:-/usr/local/bin/default-browser}"

  configure_default_browser

  for _ in $(seq 1 60); do
    if command -v xdpyinfo >/dev/null 2>&1 && xdpyinfo -display "$DISPLAY" >/dev/null 2>&1; then
      break
    fi
    sleep 1
  done

  if ! pgrep -f "$APP_MATCH" >/dev/null 2>&1; then
    nohup "$APP_CMD" >>"$LOG_FILE" 2>&1 &
  fi
}

start_bambu_studio &
