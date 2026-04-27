#!/bin/bash
set -euo pipefail

if ! command -v claude &> /dev/null; then
  curl -fsSL https://claude.ai/install.sh | bash
fi
