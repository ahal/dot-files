#!/bin/bash
set -euo pipefail

# shellcheck source=/dev/null
source "$HOME/.cargo/env"

if command -v jj &> /dev/null; then
  exit 0
fi

cargo install --locked --bin jj jj-cli
