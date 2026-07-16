#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

echo "==> Installing APT packages..."

if [ -f "$DOTFILES/packages/apt.txt" ]; then
    sudo xargs -a "$DOTFILES/packages/apt.txt" apt install -y
fi
