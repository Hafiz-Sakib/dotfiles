#!/usr/bin/env bash

set -e

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

for pkg in bash fastfetch fonts git gtk icons profile themes vscode; do
    [ -d "$pkg" ] && stow "$pkg"
done

########################################
# Install VS Code Extensions
########################################

if command -v code >/dev/null 2>&1 && [ -f "$DOTFILES/packages/vscode-extensions.txt" ]; then

    echo "==> Installing VS Code extensions..."

    while read -r extension; do
        [ -z "$extension" ] && continue
        code --install-extension "$extension" --force
    done < "$DOTFILES/packages/vscode-extensions.txt"

fi

########################################
# Install GNOME Extensions
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
echo "      Restore Complete!"
echo "========================================"
