return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {}
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        sources = {
          {name = 'path'},
          {name = 'nvim_lsp'},
          {name = 'nvim_lsp_signature_help'},
          {name = 'buffer', keyword_length = 3},
          {name = 'luasnip', keyword_length = 2},
        },
        mapping = cmp.mapping.preset.insert({
          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		  end, {"i", "s"}),
		  ["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		  end, {"i", "s"}),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      -- Get capabilities from cmp-nvim-lsp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })

      -- Configure LSP servers using vim.lsp.config (new API)
      local servers = {
        'bashls',
        'clangd',
        'dockerls',
        'esbonio',        -- sphinx
        'eslint',
        'lua_ls',
        'marksman',       -- markdown
        'pyrefly',
        'rust_analyzer',
        'taplo',          -- toml
      }

      -- Set default config for all servers
      for _, server_name in ipairs(servers) do
        vim.lsp.config(server_name, {
          capabilities = capabilities,
        })
      end

      -- Configure yamlls with custom settings
      vim.lsp.config('yamlls', {
        capabilities = capabilities,
        settings = {
          yaml = {
            keyOrdering = false,
          }
        }
      })

      -- Mason-lspconfig will automatically enable installed servers
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',         -- bash
          'clangd',         -- c++
          'dockerls',       -- docker
          'esbonio',        -- sphinx
          'eslint',         -- javascript
          'lua_ls',         -- lua
          'marksman',       -- markdown
          'pyrefly',        -- python
          'rust_analyzer',  -- rust
          'taplo',          -- toml
          'yamlls',         -- yaml
        },
      })

      require('mason-null-ls').setup({
        ensure_installed = {'ruff', 'black'},
        automatic_install = false,
        handlers = {}
      })

      require('null-ls').setup({
        on_attach = function(client, bufnr)
          vim.bo[bufnr].formatexpr = nil
        end
      })
    end
  },

  -- none-ls
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'jay-babu/mason-null-ls.nvim' },
  },

  -- Snippets
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },

  -- Useful status updates for LSP
  {
    'j-hui/fidget.nvim',
    tag = "v1.6.1",
    event = "LspAttach",
    config = function()
      require('fidget').setup()
    end
  },

  -- Workspace diagnostics
  { 'artemave/workspace-diagnostics.nvim' }
}
