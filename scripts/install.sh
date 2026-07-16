#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

echo "=================================="
echo "      Dotfiles Installation"
echo "=================================="
echo

########################################
# Add official repositories
########################################

if [ -x "$DOTFILES/scripts/install-repos.sh" ]; then
    "$DOTFILES/scripts/install-repos.sh"
fi

########################################
# Install APT packages
########################################

if [ -x "$DOTFILES/scripts/install-apt.sh" ]; then
    "$DOTFILES/scripts/install-apt.sh"
fi

########################################
# Install Flatpak packages
########################################

echo "==> Installing Flatpak packages..."

if [ -f "$DOTFILES/packages/flatpak.txt" ]; then
    while read -r pkg; do
        [ -z "$pkg" ] && continue
        flatpak install -y flathub "$pkg"
    done < "$DOTFILES/packages/flatpak.txt"
fi

########################################
# Install Snap packages
########################################

echo "==> Installing Snap packages..."

if [ -f "$DOTFILES/packages/snap.txt" ]; then
    while read -r pkg; do
        [ -z "$pkg" ] && continue
        sudo snap install "$pkg"
    done < "$DOTFILES/packages/snap.txt"
fi

########################################
# Install VS Code Extensions
########################################

echo "==> Installing VS Code extensions..."

if command -v code >/dev/null && [ -f "$DOTFILES/packages/vscode-extensions.txt" ]; then
    while read -r ext; do
        [ -z "$ext" ] && continue
        code --install-extension "$ext" --force
    done < "$DOTFILES/packages/vscode-extensions.txt"
fi

########################################
# Apply GNU Stow
########################################

echo "==> Applying GNU Stow..."

cd "$DOTFILES"

for pkg in bash dconf fastfetch fonts git gtk icons profile themes vscode; do
    [ -d "$pkg" ] && stow "$pkg"
done

########################################
# Rebuild Font Cache
########################################

echo "==> Rebuilding font cache..."

fc-cache -fv

########################################
# Restore GNOME Settings
########################################

echo "==> Restoring GNOME settings..."

if [ -f "$DOTFILES/dconf/settings.ini" ]; then
    dconf load / < "$DOTFILES/dconf/settings.ini"
fi

########################################
# Finished
########################################

echo
echo "=================================="
echo "✅ Installation Complete!"
echo "=================================="
