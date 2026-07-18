#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"

PACKAGES=(
    bash
    fastfetch
    fonts
    git
    gtk
    icons
    profile
    themes
    vscode
)

echo
echo "========================================"
echo "     Applying GNU Stow Packages"
echo "========================================"
echo

cd "$DOTFILES"

for pkg in "${PACKAGES[@]}"; do
    if [[ -d "$pkg" ]]; then
        echo "==> Stowing: $pkg"
        stow -R "$pkg"
    else
        echo "⚠️  Skipping missing package: $pkg"
    fi
done

echo
echo "==> Refreshing font cache..."
fc-cache -fv >/dev/null 2>&1

echo
echo "========================================"
echo "✅ All packages applied successfully!"
echo "========================================"
