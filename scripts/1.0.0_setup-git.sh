#!/usr/bin/env bash

set -e

clear

echo "=================================================="
echo "            Git Configuration Setup"
echo "=================================================="
echo
echo "This script will configure Git for the current user."
echo "It does NOT log you into GitHub."
echo
echo "You can safely run this on any Linux machine."
echo

# Check Git installation
if ! command -v git >/dev/null 2>&1; then
    echo "❌ Git is not installed."
    echo
    echo "Please install Git first and run this script again."
    exit 1
fi

# Get current values (if any)
CURRENT_NAME=$(git config --global user.name 2>/dev/null || true)
CURRENT_EMAIL=$(git config --global user.email 2>/dev/null || true)

if [[ -n "$CURRENT_NAME" || -n "$CURRENT_EMAIL" ]]; then
    echo "Current Git configuration:"
    echo "------------------------------------------"
    echo "Username : ${CURRENT_NAME:-Not Set}"
    echo "Email    : ${CURRENT_EMAIL:-Not Set}"
    echo "------------------------------------------"
    echo
fi

# Ask for new values
while true; do
    read -rp "Enter your Git username : " GIT_NAME
    [[ -n "$GIT_NAME" ]] && break
    echo "⚠️  Username cannot be empty."
done

while true; do
    read -rp "Enter your Git email    : " GIT_EMAIL
    [[ -n "$GIT_EMAIL" ]] && break
    echo "⚠️  Email cannot be empty."
done

echo
echo "Applying Git configuration..."
echo

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "code --wait"

echo "✅ Git configuration has been updated."
echo

echo "=================================================="
echo "              Configuration Summary"
echo "=================================================="

echo "Username       : $(git config --global user.name)"
echo "Email          : $(git config --global user.email)"
echo "Default Branch : $(git config --global init.defaultBranch)"
echo "Pull Strategy  : $(git config --global pull.rebase)"
echo "Editor         : $(git config --global core.editor)"

echo
echo "=================================================="
echo "                 Next Steps"
echo "=================================================="
echo
echo "1. Login to GitHub CLI (Recommended)"
echo
echo "   gh auth login"
echo
echo "2. Verify your Git configuration"
echo
echo "   git config --global --list"
echo
echo "3. (Optional) Generate an SSH key"
echo
echo "   ssh-keygen -t ed25519 -C \"$GIT_EMAIL\""
echo
echo "4. Add your SSH public key to GitHub"
echo
echo "   https://github.com/settings/keys"
echo
echo "🎉 Git is now ready to use!"
