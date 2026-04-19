export FZF_DEFAULT_COMMAND='rg --hidden --no-filename --no-heading --ignore-file ~/.ignore --files'
export FZF_CTRL_T_COMMAND='rg --hidden --ignore-file ~/.ignore --files'

source <(fzf --zsh)

fzf-history-widget-custom() {
  local selected num
  setopt localoptions noglobsubst pipefail 2> /dev/null
  selected=( $(eval "fc -l 1 | rg --hidden ${(q)LBUFFER}" |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS +s --tac -n2..,.. --tiebreak=index --toggle-sort=ctrl-r $FZF_CTRL_R_OPTS --query=${(q)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   fzf-history-widget-custom
bindkey '^R' fzf-history-widget-custom

fzf-history-widget-accept() {
  fzf-history-widget-custom
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^E^R' fzf-history-widget-accept

