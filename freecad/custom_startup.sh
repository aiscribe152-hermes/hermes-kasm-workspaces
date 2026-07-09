#!/usr/bin/env bash
set -euo pipefail

LOG_FILE=/tmp/freecad-startup.log
APP_CMD=/usr/local/bin/freecad
APP_MATCH=/opt/freecad/FreeCAD.AppImage

start_freecad() {
  export DISPLAY="${DISPLAY:-:1}"
  export HOME="${HOME:-/home/kasm-user}"
  export APPIMAGE_EXTRACT_AND_RUN=1

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

start_freecad &
