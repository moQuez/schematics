#!/bin/sh
set -eu

status=0

check_cmd() {
  label=$1
  cmd=$2
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "ok: $label"
  else
    echo "missing: $label ($cmd)" >&2
    status=1
  fi
}

check_cmd "codex" "codex"
check_cmd "stow" "stow"
check_cmd "jq" "jq"
check_cmd "notify-send (libnotify)" "notify-send"

exit "$status"
