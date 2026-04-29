#!/bin/bash
set -euo pipefail

if ! command -v fnm &> /dev/null; then
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir ~/.local/bin --skip-shell
fi

export PATH="$HOME/.local/bin:$PATH"
fnm install --lts
eval "$(fnm env --shell bash)"
fnm use lts-latest

npm config set prefix ~/.config/npm
