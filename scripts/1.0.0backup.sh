#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

echo "======================================="
echo "         Dotfiles Backup"
echo "======================================="
echo

########################################
# VS Code Extensions
########################################

echo "[1/12] Updating VS Code extensions..."
if command -v code >/dev/null 2>&1; then
    mkdir -p "$DOTFILES/packages"
    code --list-extensions > "$DOTFILES/packages/vscode-extensions.txt"
fi

########################################
# APT Packages
########################################

echo "[2/12] Updating APT package list..."
mkdir -p "$DOTFILES/packages"
apt-mark showmanual | sort > "$DOTFILES/packages/apt.txt"

########################################
# Flatpak Packages
########################################

echo "[3/12] Updating Flatpak package list..."
if command -v flatpak >/dev/null 2>&1; then
    flatpak list --app --columns=application | sort \
    > "$DOTFILES/packages/flatpak.txt"
fi

########################################
# Snap Packages
########################################

echo "[4/12] Updating Snap package list..."
if command -v snap >/dev/null 2>&1; then
    snap list | awk 'NR>1{print $1}' | sort \
    > "$DOTFILES/packages/snap.txt"
fi

########################################
# Fonts
########################################

echo "[5/12] Backing up Fonts..."

mkdir -p "$DOTFILES/fonts/.local/share"

if [ -d "$HOME/.local/share/fonts" ]; then
    rsync -a --delete \
    "$HOME/.local/share/fonts/" \
    "$DOTFILES/fonts/.local/share/fonts/"
fi

########################################
# Fastfetch
########################################

echo "[6/12] Backing up Fastfetch..."

mkdir -p "$DOTFILES/fastfetch/.config"

if [ -d "$HOME/.config/fastfetch" ]; then
    rsync -a --delete \
    "$HOME/.config/fastfetch/" \
    "$DOTFILES/fastfetch/.config/fastfetch/"
fi

########################################
# Bash
########################################

echo "[7/12] Backing up Bash..."

mkdir -p "$DOTFILES/bash"

if [ -f "$HOME/.bashrc" ]; then
    cp "$HOME/.bashrc" "$DOTFILES/bash/.bashrc"
fi

########################################
# Git
########################################

echo "[8/12] Backing up Git..."

mkdir -p "$DOTFILES/git"

if [ -f "$HOME/.gitconfig" ]; then
    cp "$HOME/.gitconfig" "$DOTFILES/git/.gitconfig"
fi

########################################
# GTK
########################################

echo "[9/12] Backing up GTK..."

mkdir -p "$DOTFILES/gtk/.config"

if [ -d "$HOME/.config/gtk-3.0" ]; then
    rsync -a --delete \
    "$HOME/.config/gtk-3.0/" \
    "$DOTFILES/gtk/.config/gtk-3.0/"
fi

if [ -d "$HOME/.config/gtk-4.0" ]; then
    rsync -a --delete \
    "$HOME/.config/gtk-4.0/" \
    "$DOTFILES/gtk/.config/gtk-4.0/"
fi

########################################
# GNOME Settings
########################################

echo "[10/12] Backing up GNOME settings..."

mkdir -p "$DOTFILES/dconf"

dconf dump / > "$DOTFILES/dconf/settings.ini"

########################################
# GNOME Extensions
########################################

echo "[11/12] Backing up enabled GNOME extensions..."

mkdir -p "$DOTFILES/gnome"

gsettings get org.gnome.shell enabled-extensions \
| tr -d "[]'," \
| tr ' ' '\n' \
| grep '@' \
> "$DOTFILES/gnome/extensions.txt"

########################################
# Font Cache
########################################

echo "[12/12] Rebuilding font cache..."

fc-cache -fv >/dev/null

########################################
# Git Status
########################################

echo
echo "Git status"
echo "---------------------------------------"

cd "$DOTFILES"

git status

echo

read -rp "Commit message (leave empty to skip commit): " msg

if [ -n "$msg" ]; then
    git add .
    git commit -m "$msg"
    git push
fi

echo
echo "======================================="
echo "✅ Backup Complete!"
echo "======================================="
