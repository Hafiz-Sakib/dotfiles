#!/usr/bin/env bash

set -euo pipefail

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
NC="\033[0m"

echo -e "${BLUE}==============================================${NC}"
echo -e "${BLUE}        Git Developer Setup Wizard${NC}"
echo -e "${BLUE}==============================================${NC}"
echo

if ! command -v git >/dev/null 2>&1; then
    echo -e "${YELLOW}Git is not installed.${NC}"

    if command -v apt >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y git
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y git
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -Sy --noconfirm git
    elif command -v zypper >/dev/null 2>&1; then
        sudo zypper install -y git
    else
        echo -e "${RED}Unsupported package manager. Install Git manually.${NC}"
        exit 1
    fi
fi

echo "Git Version : $(git --version)"
echo

CUR_NAME=$(git config --global user.name 2>/dev/null || true)
CUR_EMAIL=$(git config --global user.email 2>/dev/null || true)

if [[ -n "$CUR_NAME" || -n "$CUR_EMAIL" ]]; then
    echo "Current Git Configuration"
    echo "-------------------------"
    echo "Username : ${CUR_NAME:-Not Set}"
    echo "Email    : ${CUR_EMAIL:-Not Set}"
    echo
fi

while true; do
    read -rp "Git Username: " GIT_NAME
    [[ -n "$GIT_NAME" ]] && break
    echo "Username cannot be empty."
done

while true; do
    read -rp "Git Email   : " GIT_EMAIL
    [[ "$GIT_EMAIL" =~ ^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]+$ ]] && break
    echo "Please enter a valid email."
done

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "code --wait"

echo -e "${GREEN}Git configured successfully.${NC}"

if [[ ! -f "$HOME/.ssh/id_ed25519.pub" ]]; then
    echo
    read -rp "Generate SSH key now? (Y/n): " SSH
    SSH=${SSH:-Y}
    if [[ "$SSH" =~ ^[Yy]$ ]]; then
        ssh-keygen -t ed25519 -C "$GIT_EMAIL"
    fi
else
    echo -e "${GREEN}SSH key already exists.${NC}"
fi

if command -v gh >/dev/null 2>&1; then
    echo
    read -rp "Login to GitHub CLI now? (Y/n): " GH
    GH=${GH:-Y}
    if [[ "$GH" =~ ^[Yy]$ ]]; then
        gh auth login
    fi
else
    echo
    echo -e "${YELLOW}GitHub CLI (gh) is not installed.${NC}"
fi

echo
echo "=============================================="
echo "Setup Summary"
echo "=============================================="
echo "Username : $(git config --global user.name)"
echo "Email    : $(git config --global user.email)"
echo "Branch   : $(git config --global init.defaultBranch)"
echo
echo -e "${GREEN}Done! Happy Coding!${NC}"
