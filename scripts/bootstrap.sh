#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo
echo "===================================="
echo "     Linux Dotfiles Bootstrap"
echo "===================================="
echo

echo "==> Updating package lists..."
sudo apt update

echo
echo "==> Installing required packages..."

sudo apt install -y \
git \
curl \
wget \
stow \
zsh \
flatpak \
pipx \
python3-pip \
gnupg \
software-properties-common

echo
echo "==> Making scripts executable..."

chmod +x "$DOTFILES"/scripts/*.sh

echo
echo "==> Starting installation..."

"$DOTFILES/scripts/install.sh"

echo
echo "===================================="
echo " Bootstrap Complete!"
echo "===================================="
