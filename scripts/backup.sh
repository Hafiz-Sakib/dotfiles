#!/usr/bin/env bash

set -euo pipefail

VERSION="1.0.1"

echo
echo "========================================"
echo "      Dotfiles Backup v$VERSION"
echo "========================================"
echo

DOTFILES="$HOME/dotfiles"
START_TIME=$(date +%s)

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

ok()   { echo -e "${GREEN}[✔]${NC} $1"; }
warn() { echo -e "${YELLOW}[⚠]${NC} $1"; }
step() { echo -e "\n${BLUE}==>${NC} $1"; }

mkdir -p \
    "$DOTFILES/packages" \
    "$DOTFILES/dconf" \
    "$DOTFILES/gnome"

########################################
# VS Code Extensions
########################################

step "Updating VS Code extensions"

if command -v code >/dev/null 2>&1; then
    code --list-extensions | sort > "$DOTFILES/packages/vscode-extensions.txt"
    ok "VS Code extensions updated."
else
    warn "VS Code not found."
fi

########################################
# APT Packages
########################################

step "Updating APT packages"

if command -v apt-mark >/dev/null 2>&1; then
    apt-mark showmanual | sort > "$DOTFILES/packages/apt.txt"
    ok "APT package list updated."
else
    warn "APT unavailable."
fi

########################################
# Flatpak Packages
########################################

step "Updating Flatpak packages"

if command -v flatpak >/dev/null 2>&1; then
    flatpak list --app --columns=application \
        | sort > "$DOTFILES/packages/flatpak.txt"
    ok "Flatpak package list updated."
else
    warn "Flatpak unavailable."
fi

########################################
# Snap Packages
########################################

step "Updating Snap packages"

if command -v snap >/dev/null 2>&1; then
    snap list \
        | awk 'NR>1 {print $1}' \
        | sort > "$DOTFILES/packages/snap.txt"
    ok "Snap package list updated."
else
    warn "Snap unavailable."
fi

########################################
# GNOME Settings
########################################

step "Backing up GNOME settings"

if command -v dconf >/dev/null 2>&1; then
    dconf dump / > "$DOTFILES/dconf/settings.ini"
    ok "GNOME settings exported."
else
    warn "dconf unavailable."
fi

########################################
# Installed GNOME Extensions
########################################

step "Backing up installed GNOME extensions"

EXT_DIR="$HOME/.local/share/gnome-shell/extensions"

if [ -d "$EXT_DIR" ]; then
    find "$EXT_DIR" \
        -mindepth 1 \
        -maxdepth 1 \
        -type d \
        -printf "%f\n" \
        | sort > "$DOTFILES/gnome/extensions.txt"

    ok "Installed GNOME extensions updated."
else
    : > "$DOTFILES/gnome/extensions.txt"
    warn "No user-installed GNOME extensions found."
fi

########################################
# Refresh Font Cache
########################################

step "Refreshing font cache"

if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -fv >/dev/null 2>&1
    ok "Font cache refreshed."
fi

########################################
# Git Status
########################################

cd "$DOTFILES"

echo
step "Checking Git status"

git status --short

if [[ -z "$(git status --porcelain)" ]]; then
    echo
    ok "Nothing changed. Backup is already up to date."
    exit 0
fi

########################################
# Summary
########################################

APT=$(wc -l < packages/apt.txt 2>/dev/null || echo 0)
FP=$(wc -l < packages/flatpak.txt 2>/dev/null || echo 0)
SN=$(wc -l < packages/snap.txt 2>/dev/null || echo 0)
VS=$(wc -l < packages/vscode-extensions.txt 2>/dev/null || echo 0)
GE=$(wc -l < gnome/extensions.txt 2>/dev/null || echo 0)

echo
echo "========== Backup Summary =========="
echo "APT Packages       : $APT"
echo "Flatpak Packages   : $FP"
echo "Snap Packages      : $SN"
echo "VSCode Extensions  : $VS"
echo "GNOME Extensions   : $GE"
echo "===================================="

########################################
# Commit & Push
########################################

read -rp "Commit & push? [Y/N]: " ans
ans=${ans:-Y}

if [[ "$ans" =~ ^[Yy]$ ]]; then
    read -rp "Commit message (default: Backup update): " msg

    git add .

    if git diff --cached --quiet; then
        warn "Nothing staged to commit."
        exit 0
    fi

    git commit -m "${msg:-Backup update}"
    git pull --rebase
    git push

    ok "Git push completed."
else
    warn "Commit skipped."
fi

########################################
# Finished
########################################

END_TIME=$(date +%s)

echo
ok "Backup finished in $((END_TIME - START_TIME)) seconds."
