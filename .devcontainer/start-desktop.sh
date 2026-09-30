#!/usr/bin/env bash
set -euo pipefail

readonly DESKTOP_PORT=3000
readonly HEALTH_URL="http://127.0.0.1:${DESKTOP_PORT}/"
readonly LOG_FILE="/tmp/hyggemygge-desktop-check.log"

exec > >(tee -a "${LOG_FILE}") 2>&1
printf 'Kontrollerer desktop-tjenesten på port %s...\n' "${DESKTOP_PORT}"

for attempt in {1..120}; do
  if curl --fail --silent --show-error --max-time 2 "${HEALTH_URL}" >/dev/null; then
    printf 'Ubuntu-skrivebordet er klar på port %s.\n' "${DESKTOP_PORT}"
    printf 'Chromium: %s\n' "$(chromium-browser --version)"
    exit 0
  fi

  if [[ "${attempt}" == "120" ]]; then
    printf 'Desktop-tjenesten startede ikke på port %s inden for 120 sekunder.\n' "${DESKTOP_PORT}" >&2
    printf 'Containerens hovedproces: ' >&2
    ps -p 1 -o args= >&2 || true
    printf 'Lyttende porte:\n' >&2
    ss -ltnp >&2 || true
    exit 1
  fi

  sleep 1
done
