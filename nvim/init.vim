function! Dot(path)
  return "~/.config/nvim/" . a:path
endfunction

for file in split(glob(Dot("custom/*.vim")), "\n")
  execute "source" file
endfor

if filereadable("~/.nvim.local.vim")
  source ~/.nvim.local.vim
endif
