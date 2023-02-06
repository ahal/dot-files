### https://github.com/BlackReloaded/wsl2-ssh-pageant#bashzsh
#WIN_USER="ahal"
#SSH_DIR="${HOME}/.ssh" #
#mkdir -p "${SSH_DIR}"
#wsl2_ssh_pageant_bin="${SSH_DIR}/wsl2-ssh-pageant.exe"
#ln -sf "/mnt/c/Users/${WIN_USER}/.ssh/wsl2-ssh-pageant.exe" "${wsl2_ssh_pageant_bin}"
#
#listen_socket() {
#  sock_path="$1" && shift
#  fork_args="${sock_path},fork"
#  exec_args="${wsl2_ssh_pageant_bin} $@"
#
#  if ! ps x | grep -v grep | grep -q "${fork_args}"; then
#    rm -f "${sock_path}"
#    (setsid nohup socat "UNIX-LISTEN:${fork_args}" "EXEC:${exec_args}" &>/dev/null &)
#  fi
#}
#
## SSH
#export SSH_AUTH_SOCK="${SSH_DIR}/agent.sock"
#listen_socket "${SSH_AUTH_SOCK}"
#
## GPG
#export GPG_AGENT_SOCK="${HOME}/.gnupg/S.gpg-agent"
#listen_socket "${GPG_AGENT_SOCK}" --gpg S.gpg-agent
#
## GPG extra for agent forwarding to devcontainers in VS Code
#export GPG_AGENT_SOCK_EXTRA="${HOME}/.gnupg/S.gpg-agent.extra"
#listen_socket "${GPG_AGENT_SOCK_EXTRA}" --gpg S.gpg-agent.extra
#
#unset wsl2_ssh_pageant_bin
###
