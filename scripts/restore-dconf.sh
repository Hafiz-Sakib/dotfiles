#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"

echo "==> Restoring GNOME settings..."

if ! command -v dconf >/dev/null 2>&1; then
    echo "⚠️  dconf is not installed."
    exit 0
fi

if [ -f "$DOTFILES/dconf/settings.ini" ]; then
    dconf load / < "$DOTFILES/dconf/settings.ini"
    echo "✅ GNOME settings restored."
else
    echo "⚠️  No dconf backup found."
fi
