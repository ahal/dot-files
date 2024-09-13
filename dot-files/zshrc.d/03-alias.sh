# aliases
alias cd="pushd -q"
alias ag="ag --path-to-agignore ~/.ignore"
alias dc="docker compose"
alias indent="python -m json.tool"
alias isitmfbt="wget -qO - isitmfbt.com | grep 'theTime' | sed -e 's/<[^>]*>//g'"
alias jsonsort="jq -S -f ~/bin/sort.jq"
alias ls="exa"
alias pg="ps -ef | grep"
alias pysite="python -c 'import site; print(site.getsitepackages()[0])'"
alias rg="rg --ignore-file $HOME/.ignore --hidden"
alias usage="du -h --max-depth=1 2> /dev/null | sort -h -r | head -n20"

# flatpaks
alias meld="org.gnome.meld"
alias nvim="io.neovim.nvim"

if $IS_WSL; then
  alias xclip="xclip -selection clipboard"
fi

