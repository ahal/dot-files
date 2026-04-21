#!/bin/bash
set -euo pipefail

mkdir -p "$HOME/bin"

# tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone --branch master https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
