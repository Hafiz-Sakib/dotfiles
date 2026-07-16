#!/usr/bin/env bash

set -e

echo "Installing base packages..."

sudo apt update

sudo apt install -y \
git \
curl \
wget \
stow \
zsh \
flatpak \
gnupg \
software-properties-common
