return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'zschreur/telescope-jj.nvim',
      {
        'nvim-telescope/telescope-live-grep-args.nvim', version = "^1.1.0"
      }
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')

      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-j>'] = 'move_selection_next',
              ['<C-k>'] = 'move_selection_previous',
            },
          },
        },
      }

      -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, 'fzf')
      telescope.load_extension('jj')
      telescope.load_extension('live_grep_args')

      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        telescope.builtin.current_buffer_fuzzy_find(telescope.themes.get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer]' })

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sr', telescope.extensions.jj.files, { desc = '[S]earch Files [R]epo' })
      vim.keymap.set('n', '<leader>sc', telescope.extensions.jj.diff, { desc = '[S]earch Files in [C]hange' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', telescope.extensions.live_grep_args.live_grep_args,
        { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sG',
        function() telescope.extensions.live_grep_args.live_grep_args { search_dirs = { vim.fn.expand('%:p:h') } } end,
        { desc = '[S]earch by [G]rep in Current Buffer Parent' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
}
