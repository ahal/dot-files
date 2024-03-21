return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },
    {
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
      dependencies = { 'williamboman/mason-lspconfig.nvim' },
    },

    -- none-ls
    {
      'nvimtools/none-ls.nvim',
      dependencies = { 'jay-babu/mason-null-ls.nvim' },
    },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
      },
    },

    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },

    -- Useful status updates for LSP
    {
      'j-hui/fidget.nvim',
      tag = "legacy",
      event = "LspAttach"
    },

    -- Workspace diagnostics
    { 'artemave/workspace-diagnostics.nvim' }
  }
}
