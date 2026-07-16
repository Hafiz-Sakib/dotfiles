#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

echo "==> Installing APT packages..."
if [ -f "$DOTFILES/packages/apt.txt" ]; then
    sudo xargs -a "$DOTFILES/packages/apt.txt" apt install -y
fi

echo "==> Installing Flatpak packages..."
if [ -f "$DOTFILES/packages/flatpak.txt" ]; then
    while read -r pkg; do
        [ -z "$pkg" ] && continue
        flatpak install -y flathub "$pkg"
    done < "$DOTFILES/packages/flatpak.txt"
fi

echo "==> Installing VS Code extensions..."
if command -v code >/dev/null && [ -f "$DOTFILES/packages/vscode-extensions.txt" ]; then
    while read -r ext; do
        [ -z "$ext" ] && continue
        code --install-extension "$ext" --force
    done < "$DOTFILES/packages/vscode-extensions.txt"
fi

echo "==> Applying GNU Stow..."
cd "$DOTFILES"

for pkg in bash fastfetch fonts git gtk icons profile themes vscode; do
    [ -d "$pkg" ] && stow "$pkg"
done

echo "==> Rebuilding font cache..."
fc-cache -fv

echo "==> Restoring GNOME settings..."
if [ -f "$DOTFILES/dconf/settings.ini" ]; then
    dconf load / < "$DOTFILES/dconf/settings.ini"
fi

echo
echo "✅ Installation complete!"
