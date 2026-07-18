#!/usr/bin/env bash

set -euo pipefail

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

if command -v flatpak >/dev/null 2>&1 && [ -f "$DOTFILES/packages/flatpak.txt" ]; then
    while IFS= read -r pkg; do
        [[ -z "$pkg" ]] && continue
        flatpak install -y flathub "$pkg"
    done < "$DOTFILES/packages/flatpak.txt"
fi

########################################
# Install Snap packages
########################################

echo "==> Installing Snap packages..."

if command -v snap >/dev/null 2>&1 && [ -f "$DOTFILES/packages/snap.txt" ]; then
    while IFS= read -r pkg; do
        [[ -z "$pkg" ]] && continue
        sudo snap install "$pkg"
    done < "$DOTFILES/packages/snap.txt"
fi

########################################
# Install VS Code Extensions
########################################

echo "==> Installing VS Code extensions..."

if command -v code >/dev/null 2>&1 && [ -f "$DOTFILES/packages/vscode-extensions.txt" ]; then
    while IFS= read -r ext; do
        [[ -z "$ext" ]] && continue
        code --install-extension "$ext" --force
    done < "$DOTFILES/packages/vscode-extensions.txt"
fi

########################################
# Apply GNU Stow
########################################

echo "==> Applying GNU Stow..."

cd "$DOTFILES"

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

for pkg in "${PACKAGES[@]}"; do
    if [[ -d "$pkg" ]]; then
        echo "==> Stowing: $pkg"
        stow -R "$pkg"
    else
        echo "⚠️  Skipping missing package: $pkg"
    fi
done

########################################
# Restore GNOME Extensions
########################################

if [ -x "$DOTFILES/scripts/restore-extensions.sh" ]; then
    "$DOTFILES/scripts/restore-extensions.sh"
fi

########################################
# Restore GNOME Settings (dconf)
########################################

if [ -x "$DOTFILES/scripts/restore-dconf.sh" ]; then
    "$DOTFILES/scripts/restore-dconf.sh"
fi

########################################
# Refresh Font Cache
########################################

echo "==> Refreshing font cache..."

fc-cache -fv >/dev/null 2>&1

########################################
# Finished
########################################

echo
echo "=================================="
echo "✅ Installation Complete!"
echo "=================================="
