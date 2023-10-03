-- LSP settings.
local lsp = require('lsp-zero').preset('recommended')

--  This function gets run when an LSP connects to a particular buffer.
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({buffer = bufnr })
end)

-- Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- Setup autocomplete
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})

-- Turn on lsp status information
require('fidget').setup()

local none_ls = require('null-ls')
local none_opts = lsp.build_options('null-ls', {})

-- Enable none-ls
require('mason-null-ls').setup({
  ensure_installed = {'ruff', 'black'},
  automatic_install = false,
  handlers = {},
})

none_ls.setup({
  on_attach = function(client, bufnr)
    none_opts.on_attach(client, bufnr)
    vim.bo[bufnr].formatexpr = nil
  end
})

-- Language server overrides
local lspconfig = require('lspconfig')
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      keyOrdering = false,
    }
  }
})
