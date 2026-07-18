#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/dotfiles"

echo
echo "========================================"
echo "      Restoring Linux Dotfiles"
echo "========================================"
echo

########################################
# Install GNU Stow
########################################

if ! command -v stow >/dev/null 2>&1; then
    echo "==> Installing GNU Stow..."
    sudo apt update
    sudo apt install -y stow
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
# Install VS Code Extensions
########################################

echo "==> Installing VS Code extensions..."

if command -v code >/dev/null 2>&1 && [ -f "$DOTFILES/packages/vscode-extensions.txt" ]; then
    while IFS= read -r extension; do
        [[ -z "$extension" ]] && continue
        code --install-extension "$extension" --force
    done < "$DOTFILES/packages/vscode-extensions.txt"
fi

########################################
# Restore GNOME Extensions
########################################

if [ -x "$DOTFILES/scripts/restore-extensions.sh" ]; then
    "$DOTFILES/scripts/restore-extensions.sh"
fi

########################################
# Restore GNOME Settings
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
echo "========================================"
echo "✅ Restore Complete!"
echo "========================================"
