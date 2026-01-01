#!/bin/sh
set -eu

if ! command -v pacman >/dev/null 2>&1; then
  echo "error: pacman not found; this script targets Arch Linux" >&2
  exit 1
fi

packages="stow jq libnotify"
missing=""

for pkg in $packages; do
  if ! pacman -Qi "$pkg" >/dev/null 2>&1; then
    missing="$missing $pkg"
  fi
done

if [ -z "$missing" ]; then
  echo "All dependencies already installed."
  exit 0
fi

echo "Installing:$missing"

if command -v sudo >/dev/null 2>&1; then
  sudo pacman -S --needed $missing
else
  pacman -S --needed $missing
fi
