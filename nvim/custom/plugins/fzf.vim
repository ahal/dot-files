" === FZF ===
function! s:find_moz_root()
  return fnamemodify(findfile('moz.build', '.;'), ':h')
endfunction

command! -bang FilesDir call fzf#vim#files(expand('%:p:h'), <bang>0)
command! -bang FilesMozRoot call fzf#vim#files(s:find_moz_root(), <bang>0)

let findcmd = 'rg --column --line-number --no-heading --fixed-strings --smart-case --color=always '
command! -bang -nargs=* Find call fzf#vim#grep(findcmd . shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindMozRoot call fzf#vim#grep(findcmd . shellescape(<q-args>) . ' ' . shellescape(s:find_moz_root()), 1, <bang>0)

"let findnopathcmd = 'rg --no-heading --no-line-number --no-filename --smart-case --color=always '
"command! -bang -nargs=* FindNoPath call fzf#vim#grep(findnopathcmd . shellescape(<q-args>), 1, <bang>0)
"command! -bang -nargs=* FindNoPathMozRoot call fzf#vim#grep(findnopathcmd . shellescape(<q-args>) . ' ' . shellescape(s:find_moz_root()), 1, <bang>0)

nmap <leader>w :Files<cr>
nmap <leader>e :Buffers<cr>
nmap <leader>r :FilesMozRoot<cr>
nmap <leader>t :FilesDir<cr>
nmap <leader>G :FindMozRoot<cr>
nmap <leader>g :Telescope live_grep<cr>
"nmap <leader>F :FindNoPath<cr>
"nmap <leader>f :FindNoPathMozRoot<cr>
nmap <leader>c :Tags<cr>
nmap <leader>/ :Lines<cr>
