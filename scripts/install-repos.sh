#!/usr/bin/env bash

set -e

echo "==> Adding third-party repositories..."

sudo mkdir -p /etc/apt/keyrings

##############################
# Google Chrome
##############################

if [ ! -f /etc/apt/sources.list.d/google-chrome.list ]; then
    wget -qO- https://dl.google.com/linux/linux_signing_key.pub \
        | sudo gpg --dearmor -o /etc/apt/keyrings/google.gpg

    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
        | sudo tee /etc/apt/sources.list.d/google-chrome.list >/dev/null
fi

##############################
# VS Code
##############################

if [ ! -f /etc/apt/sources.list.d/vscode.list ]; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
        | sudo gpg --dearmor -o /etc/apt/keyrings/vscode.gpg

    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/vscode.gpg] https://packages.microsoft.com/repos/code stable main" \
        | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
fi


##############################
# Node.js LTS
##############################

if [ ! -f /etc/apt/sources.list.d/nodesource.list ]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash -
fi

sudo apt update
