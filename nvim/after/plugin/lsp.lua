-- LSP settings.
local lsp = require('lsp-zero')

--  This function gets run when an LSP connects to a particular buffer.
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({buffer = bufnr })
end)

-- Configure mason
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'bashls',
    'clangd',
    'dockerls',
    'esbonio',        -- sphinx
    'eslint',
    'lua_ls',
    'marksman',       -- markdown
    'pyright',
    'rust_analyzer',
    'taplo',          -- toml
    'yamlls',
  },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  },
})

-- Setup autocomplete
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'codeium'},
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
lspconfig.pyright.setup({
  on_attach = function(client, bufnr)
    require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
  end
})
