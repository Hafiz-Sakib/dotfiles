#!/usr/bin/env bash
set -u

DOTFILES="$HOME/dotfiles"
START_TIME=$(date +%s)

GREEN="\033[0;32m"; YELLOW="\033[1;33m"; RED="\033[0;31m"; BLUE="\033[0;34m"; NC="\033[0m"
ok(){ echo -e "${GREEN}[✔]${NC} $1"; }
warn(){ echo -e "${YELLOW}[⚠]${NC} $1"; }
step(){ echo -e "\n${BLUE}==>${NC} $1"; }

mkdir -p "$DOTFILES/packages" "$DOTFILES/dconf" "$DOTFILES/gnome"

step "Updating VS Code extensions"
command -v code >/dev/null 2>&1 && code --list-extensions | sort > "$DOTFILES/packages/vscode-extensions.txt" && ok "VS Code updated." || warn "VS Code unavailable."

step "Updating APT packages"
command -v apt-mark >/dev/null 2>&1 && apt-mark showmanual | sort > "$DOTFILES/packages/apt.txt" && ok "APT updated." || warn "apt unavailable."

step "Updating Flatpak packages"
if command -v flatpak >/dev/null 2>&1; then
 flatpak list --app --columns=application | sort > "$DOTFILES/packages/flatpak.txt"
 ok "Flatpak updated."
else warn "Flatpak unavailable."; fi

step "Updating Snap packages"
if command -v snap >/dev/null 2>&1; then
 snap list | awk 'NR>1{print $1}' | sort > "$DOTFILES/packages/snap.txt"
 ok "Snap updated."
else warn "Snap unavailable."; fi

step "Backing up GNOME settings"
if command -v dconf >/dev/null 2>&1; then
 dconf dump / > "$DOTFILES/dconf/settings.ini"
 ok "dconf exported."
fi

step "Backing up enabled GNOME extensions"
if command -v gsettings >/dev/null 2>&1; then
 gsettings get org.gnome.shell enabled-extensions | tr -d "[]'," | tr ' ' '\n' | grep '@' > "$DOTFILES/gnome/extensions.txt" || true
 ok "Extensions updated."
fi

step "Refreshing font cache"
command -v fc-cache >/dev/null 2>&1 && fc-cache -fv >/dev/null 2>&1 && ok "Font cache refreshed."

cd "$DOTFILES" || exit 1

echo
git status --short

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

read -rp "Commit & push? [y/N]: " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
 read -rp "Commit message: " msg
 git add .
 git commit -m "${msg:-Backup update}"
 git push
 ok "Git push completed."
else
 warn "Commit skipped."
fi

END_TIME=$(date +%s)
ok "Backup finished in $((END_TIME-START_TIME)) seconds."
