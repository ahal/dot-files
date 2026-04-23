#!/bin/bash
set -euo pipefail

VERSION="0.12.2"
CURRENT=$(nvim --version 2>/dev/null | grep -oP 'NVIM \Kv\S+' || echo "none")

if [ "v${VERSION}" = "$CURRENT" ]; then
  exit 0
fi

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

curl -L -o "$TMPDIR/nvim.tar.gz" "https://github.com/neovim/neovim/releases/download/v${VERSION}/nvim-linux-x86_64.tar.gz"

rm -rf "$HOME/opt/neovim"
mkdir -p "$HOME/opt/neovim"
tar -xzf "$TMPDIR/nvim.tar.gz" -C "$HOME/opt/neovim" --strip-components=1

mkdir -p "$HOME/bin"
ln -sf "$HOME/opt/neovim/bin/nvim" "$HOME/bin/nvim"
