#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"

echo "==> Restoring GNOME Extensions..."

# Install gext if needed
if ! command -v gext >/dev/null 2>&1; then
    echo "Installing gnome-extensions-cli..."
    pipx install gnome-extensions-cli
fi

if [ ! -f "$DOTFILES/gnome/extensions.txt" ]; then
    echo "No extensions.txt found."
    exit 0
fi

while read -r ext; do
    [ -z "$ext" ] && continue

    # Skip system extensions
    if gnome-extensions info "$ext" >/dev/null 2>&1; then
        path=$(gnome-extensions info "$ext" | awk -F': ' '/Path:/ {print $2}')

        if [[ "$path" == /usr/* ]]; then
            echo "Skipping system extension: $ext"
            continue
        fi
    fi

    echo "Installing $ext ..."
    gext install "$ext" || true

    gnome-extensions enable "$ext" 2>/dev/null || true

done < "$DOTFILES/gnome/extensions.txt"

echo
echo "✅ GNOME Extensions restored."
