#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

echo "==> Restoring GNOME settings..."

if [ -f "$DOTFILES/dconf/settings.ini" ]; then
    dconf load / < "$DOTFILES/dconf/settings.ini"
    echo "✅ GNOME settings restored."
else
    echo "⚠️ No dconf backup found."
fi
