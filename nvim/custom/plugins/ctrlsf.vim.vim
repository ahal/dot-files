" === CtrlSF ===
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '80%'
let g:ctrlsf_auto_focus = { "at": "start" }
let g:ctrlsf_extra_backend_args = {
  \ 'rg': '--ignore-file=~/.ignore --glob "!objdirs"'
  \ }
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
