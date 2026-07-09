#!/usr/bin/env bash
set -euo pipefail

LOG_FILE=/tmp/bambu-studio-startup.log
APP_CMD=/usr/local/bin/bambu-studio
APP_MATCH=/opt/bambu-studio/squashfs-root/bin/bambu-studio

start_bambu_studio() {
  export DISPLAY="${DISPLAY:-:1}"
  export HOME="${HOME:-/home/kasm-user}"

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
