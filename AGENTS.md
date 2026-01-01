# Agent Notes

This repository holds personal dotfiles and configuration for an Arch Linux setup (2015 MacBook Pro Retina) using AwesomeWM. It is designed to give coding agents fast context when debugging or adjusting configs.

Guidelines:

- Prefer POSIX sh or broadly compatible shell scripts; avoid Python/Node/Ruby unless clearly justified.
- Keep dependencies minimal; favor tools easily installed via `pacman` (e.g., `rg`, `fzf`).
- Use GNU Stow for dotfiles: each subfolder in `stow/` is a package stowed into `~`.
- Keep documentation minimal and update this file when new tooling or structure is introduced.

Planned layout:

- `stow/` for dotfiles managed by Stow.
- `scripts/` for bootstrap and helper scripts.
- `assets/` for static artifacts.
