NPM_PACKAGES="${HOME}/.config/npm-packages"

export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
