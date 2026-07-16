#!/bin/bash

set -e

DOTFILES="$HOME/dotfiles"

echo "========== Dotfiles Backup =========="

echo "[1/7] Updating VS Code extensions..."
code --list-extensions > "$DOTFILES/packages/vscode-extensions.txt"

echo "[2/7] Updating APT package list..."
apt-mark showmanual > "$DOTFILES/packages/apt.txt"

echo "[3/7] Updating Flatpak package list..."
flatpak list --app --columns=application > "$DOTFILES/packages/flatpak.txt"

echo "[4/7] Updating font cache..."
fc-cache -fv >/dev/null

echo "[5/7] Git status"
cd "$DOTFILES"
git status

echo
read -p "Commit message (leave empty to skip commit): " msg

if [ -n "$msg" ]; then
    git add .
    git commit -m "$msg"
    git push
fi

echo
echo "✅ Backup completed!"
