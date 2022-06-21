lua << EOF
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local custom_lsp_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Use LSP as the handler for omnifunc.
  --    See `:help omnifunc` and `:help ins-completion` for more information.
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  require('aerial').on_attach(client, bufnr)
end
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require"lspconfig".bashls.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
}

require'lspconfig'.dockerls.setup{
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
}

require"lspconfig".esbonio.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require"lspconfig".util.root_pattern(".git", ".hg")
}

require"lspconfig".jsonls.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require"lspconfig".util.root_pattern(".git", ".hg")
}

require"lspconfig".pyright.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require"lspconfig".util.root_pattern(".git", ".hg")
}

require"lspconfig".yamlls.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require"lspconfig".util.root_pattern(".git", ".hg")
}
EOF

command! -nargs=0 Format :lua vim.lsp.buf.formatting()
