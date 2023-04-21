return {
  -- LSP
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
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

      -- null-ls
      {
        'jose-elias-alvarez/null-ls.nvim',
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
      { 'j-hui/fidget.nvim' },
    }
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'lewis6991/gitsigns.nvim',

  {
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    config = function()
      -- Set lualine as statusline
      -- See `:help lualine.txt`
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'onedark',
          component_separators = '|',
          section_separators = '',
        }
      }
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
    config = function()
      -- See `:help indent_blankline.txt`
      require('indent_blankline').setup {
        char = '┊',
        show_trailing_blankline_indent = false,
      }
    end
  },

  {
    'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
    config = function()
      require('Comment').setup()
    end
  },
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',            branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd('colorscheme carbonfox')
    end
  },

  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        mode = "document_diagnostics",
      }
    end
  },

  {
    'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup()
    end
  },

  'chaoren/vim-wordmotion',
  'mbbill/undotree',

  {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup()
    end
  },

  'Vimjas/vim-python-pep8-indent',

}
