#!/bin/sh
# Codex notify hook for libnotify (notify-send).

if [ "$#" -ne 1 ]; then
  exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
  exit 0
fi

if ! command -v notify-send >/dev/null 2>&1; then
  exit 0
fi

payload=$1

notif_type=$(printf '%s' "$payload" | jq -r '.type // empty' 2>/dev/null) || exit 0
if [ "$notif_type" != "agent-turn-complete" ]; then
  exit 0
fi

cwd=$(printf '%s' "$payload" | jq -r '.cwd // empty' 2>/dev/null)
last_msg=$(printf '%s' "$payload" | jq -r '.["last-assistant-message"] // empty' 2>/dev/null)
inputs=$(printf '%s' "$payload" | jq -r '.["input-messages"] // [] | join(" ")' 2>/dev/null)

if [ -n "$cwd" ]; then
  project=${cwd##*/}
else
  project="Codex"
fi

title="Codex: $project"

if [ -n "$last_msg" ]; then
  message=$last_msg
else
  message=$inputs
fi

if [ -z "$message" ]; then
  message="Turn complete"
fi

message=$(printf '%s' "$message" | tr '\n\t' '  ' | tr -s ' ')
message=$(printf '%s' "$message" | cut -c1-300)

notify-send "$title" "$message" >/dev/null 2>&1 || true
