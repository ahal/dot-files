# yubikey

# Enables ssh authentication, but causes issues under WSL.
if ! $IS_WSL; then
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
  export GPG_TTY="$TTY"
fi
