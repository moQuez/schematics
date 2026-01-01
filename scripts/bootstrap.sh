#!/bin/sh
set -eu

usage() {
    echo "Usage: $0 [--all | <package>...]" >&2
    exit 1
}

if [ $# -eq 0 ]; then
    usage
fi

if ! command -v stow >/dev/null 2>&1; then
    echo "error: 'stow' is not installed" >&2
    exit 1
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(CDPATH= cd -- "$script_dir/.." && pwd)
stow_dir="$repo_root/stow"

if [ ! -d "$stow_dir" ]; then
    echo "error: stow directory not found at $stow_dir" >&2
    exit 1
fi

if [ "$1" = "--all" ]; then
    shift
    if [ $# -ne 0 ]; then
        echo "error: --all does not accept package names" >&2
        usage
    fi

    set --
    for d in "$stow_dir"/*; do
        if [ -d "$d" ]; then
            set -- "$@" "$(basename "$d")"
        fi
    done

    if [ $# -eq 0 ]; then
        echo "error: no packages found in $stow_dir" >&2
        exit 1
    fi
fi

for pkg in "$@"; do
    if [ ! -d "$stow_dir/$pkg" ]; then
        echo "error: package not found: $pkg" >&2
        exit 1
    fi
done

stow -d "$stow_dir" -t "$HOME" "$@"
