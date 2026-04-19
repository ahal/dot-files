#!/bin/bash
set -euo pipefail

if [ ! -d "$HOME/.config/fzf" ]; then
  git clone --branch master https://github.com/junegunn/fzf "$HOME/.config/fzf"
fi

"$HOME/.config/fzf/install" --all --no-update-rc
