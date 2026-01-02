# schematics

Personal dotfiles and configuration for my Arch Linux setup (2015 MacBook Pro Retina) with AwesomeWM. This repo is primarily for my own use and for faster context when working with coding agents.

Notes:

- Use GNU Stow to manage dotfiles from `stow/` into `~`.
- Bootstrap: `scripts/bootstrap.sh --all` or `scripts/bootstrap.sh <package...>`.
- Setup deps: `scripts/setup.sh`; verify: `scripts/doctor.sh`.
- Keep dependencies minimal and shell-friendly (POSIX sh when possible).
- Focus is this machine first; shared config between machines may come later.
- Apps list: `apps.md`.

Planned structure:

- `stow/` for Stow packages (e.g., `stow/bash`, `stow/x11`, `stow/awesome`).
- `scripts/` for bootstrap and helper scripts.
- `assets/` for static artifacts (themes, icons, etc).
