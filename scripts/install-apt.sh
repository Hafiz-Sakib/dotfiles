#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"

echo "==> Installing APT packages..."

if [ -f "$DOTFILES/packages/apt.txt" ]; then
    sudo xargs -a "$DOTFILES/packages/apt.txt" apt install -y
fi
