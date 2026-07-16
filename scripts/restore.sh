#!/bin/bash

set -e

DOTFILES="$HOME/dotfiles"

echo "========== Restoring Dotfiles =========="

if ! command -v stow >/dev/null 2>&1; then
    echo "Installing GNU Stow..."
    sudo apt update
    sudo apt install -y stow
fi

cd "$DOTFILES"

echo "Applying dotfiles..."
stow bash git profile vscode fastfetch gtk fonts

echo "Updating font cache..."
fc-cache -fv >/dev/null

if command -v code >/dev/null 2>&1; then
    echo "Installing VS Code extensions..."
    while read extension; do
        code --install-extension "$extension" --force
    done < packages/vscode-extensions.txt
fi

echo
echo "✅ Restore completed!"
