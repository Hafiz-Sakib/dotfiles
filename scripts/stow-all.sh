#!/usr/bin/env bash

set -e

cd "$HOME/dotfiles"

echo "Applying GNU Stow..."

stow bash
stow git
stow profile

echo "Done!"
