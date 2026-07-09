#!/usr/bin/env bash
set -euo pipefail

LOG_FILE=/tmp/openscad-startup.log
APP_CMD=/usr/bin/openscad

start_openscad() {
  export DISPLAY="${DISPLAY:-:1}"
  export HOME="${HOME:-/home/kasm-user}"

  for _ in $(seq 1 60); do
    if command -v xdpyinfo >/dev/null 2>&1 && xdpyinfo -display "$DISPLAY" >/dev/null 2>&1; then
      break
    fi
    sleep 1
  done

  if ! pgrep -x openscad >/dev/null 2>&1; then
    nohup "$APP_CMD" >>"$LOG_FILE" 2>&1 &
  fi
}

start_openscad &
