#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

echo "========== Dotfiles Backup =========="

echo "[1/5] Updating VS Code extensions..."
code --list-extensions > "$DOTFILES/packages/vscode-extensions.txt"

echo "[2/5] Updating APT package list..."
apt-mark showmanual > "$DOTFILES/packages/apt.txt"

echo "[3/5] Updating Flatpak package list..."
flatpak list --app --columns=application > "$DOTFILES/packages/flatpak.txt" || true

echo "[4/5] Checking Git status..."
git -C "$DOTFILES" status

echo
echo "✅ Backup completed!"
