#!/bin/bash
set -euo pipefail

mkdir -p "$HOME/bin"
cd "$HOME/bin"

LATEST=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name)
CURRENT=$(nvim --version 2>/dev/null | grep -oP 'NVIM \K\S+' || echo "none")

if [ "$LATEST" != "$CURRENT" ]; then
  curl --clobber -L -o nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod +x nvim.appimage
  ln -sf nvim.appimage nvim
fi
