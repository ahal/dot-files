lua << EOF
require("dap-python").setup("~/.pyenv/versions/neovim/bin/python")
require("dap-python").test_runner = "pytest"

table.insert(require('dap').configurations.python, {
    name = "Taskgraph Full",
    type = "python",
    request = "launch",
    program = "/home/ahal/.pyenv/versions/taskgraph/bin/taskgraph",
    args = {"full"},
    cwd = vim.fn.getcwd(),
    console = "integratedTerminal",
    justMyCode = false,
})
EOF

" General
nnoremap <silent> <F9> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>dlp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

" Python
nnoremap <silent> <leader>dn :lua require('dap-python').test_method()<CR>
nnoremap <silent> <leader>df :lua require('dap-python').test_class()<CR>
vnoremap <silent> <leader>ds <ESC>:lua require('dap-python').debug_selection()<CR>
