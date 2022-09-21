lua << EOF
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

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

  vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
})
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").bashls.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
}

require('lspconfig').dockerls.setup{
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
}

require("lspconfig").esbonio.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require"lspconfig".util.root_pattern(".git", ".hg")
}

require("lspconfig").eslint.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require"lspconfig".util.root_pattern(".git", ".hg")
}

require("lspconfig").jsonls.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require"lspconfig".util.root_pattern(".git", ".hg")
}

require("lspconfig").rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    settings = {
        ["rust-analyzer"] = {
            diagnostics = {
                disabled = {"inactive-code"},
            },
        }
    }
})

require("lspconfig").sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require("lspconfig").util.root_pattern(".git", ".hg"),
    settings = {
      Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
      },
    },
}

require("lspconfig").pyright.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require"lspconfig".util.root_pattern(".git", ".hg")
}

require("lspconfig").yamlls.setup {
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    root_dir = require"lspconfig".util.root_pattern(".git", ".hg")
}

vim.api.nvim_create_user_command(
    'Format',
    vim.lsp.buf.format,
    {bang = true, desc = 'Format the file.'}
)
EOF
