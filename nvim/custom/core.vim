let g:python3_host_prog = '/home/ahal/.pyenv/versions/neovim/bin/python'
filetype on
filetype plugin indent on
syntax on

" === Configuration ===
" UI
set background=dark
set cursorcolumn
set ignorecase      " ignore case when searching
set smartcase
set incsearch       " incremental search
set hlsearch        " hilight search items
set ruler           " always show current position
set magic           " for regexes
set number
set nowrap
set scrolloff=10
set showcmd
set showmatch       " show matching brackets
set infercase
set title
set wildmenu

" Tabbing
set hidden
set expandtab
set autoindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Programs
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

" Navigation Mappings
let mapleader = ";"
map <C-q> :bp<bar>sp<bar>bn<bar>bd<cr>
map <C-l> <C-w>l
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-h> <C-w>h
map <C-S-k> <C-y>
map <C-S-j> <C-e>
map <C-Left> :tabp<cr>
map <C-Right> :tabn<cr>
map <leader><leader> <C-^>

map _ k^
map + j^
map - k$
map = j$

" Terminal
tnoremap <ESC> <C-\><C-n>
if has('nvim')
    let $EDITOR = 'nvr -cc split --remote-wait'
endif
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" Location / QuickFix
map <A-j> :lnext<cr>
map <A-k> :lprev<cr>
map <C-A-j> :cnext<cr>
map <C-A-k> :cprev<cr>

" Folding
set foldlevel=99
nnoremap <space> za

" File open mappings
cnoremap %% <C-R>=expand("%:p:h") . "/" <cr>
map <leader>n :e %%

" Colours
set termguicolors
hi CursorColumn guibg=#404040
hi Search cterm=None ctermfg=red ctermbg=grey
hi Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000

" === File types ===
" markdown
au BufRead,BufNewFile *.md set filetype=markdown
" autocmd FileType markdown syn clear mkdLineBreak
autocmd FileType markdown setlocal spell! spelllang=en
autocmd FileType markdown setlocal textwidth=100
autocmd FileType markdown setlocal wrap

" js
au BufRead,BufNewFile *.jsm set filetype=javascript
au BufRead,BufNewFile *.sjs set filetype=javascript

" yaml
au BufRead,BufNewFile *.yml set filetype=yaml

" === Custom ===
" Delete trailing whitespace on <F5>
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Spell check toggle
map <F6> :setlocal spell! spelllang=en_ca<CR> :setlocal textwidth=100<CR> :setlocal wrap<CR>
hi SpellBad ctermbg=060

" Open terminal
let s:terminal_buffers = {}

function! TerminalOpen()
  let tabid = tabpagenr()

  " Check if buffer exists, if not create a window and a buffer
  if !has_key(s:terminal_buffers, tabid)
    " Create a new terminal buffer
    terminal
    let s:terminal_buffers[tabid] = bufnr('%')
  else
    exe "buffer " . s:terminal_buffers[tabid]
  endif
endfunction

nnoremap <F8> :call TerminalOpen()<CR>
