#!/usr/bin/env bash

set -e

echo "Restoring dotfiles..."

"$HOME/dotfiles/scripts/stow-all.sh"

echo "Restore completed!"
