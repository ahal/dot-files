lua << EOF
require("trouble").setup {
    mode = "document_diagnostics",
}
EOF

nnoremap <leader>x <cmd>TroubleToggle<cr>
