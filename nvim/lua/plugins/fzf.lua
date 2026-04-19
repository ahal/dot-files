return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local fzf = require('fzf-lua')
      local actions = require('fzf-lua.actions')

      fzf.setup({
        previewers = {
          bat = { args = '--style=numbers,changes --color=always' },
        },
        defaults = { previewer = 'bat' },
        keymap = {
          fzf = {
            ['ctrl-j'] = 'down',
            ['ctrl-k'] = 'up',
          },
        },
      })

      local function jj_files()
        fzf.fzf_exec('jj file list', {
          prompt = 'JJ Files> ',
          actions = { ['default'] = actions.file_edit },
          previewer = 'builtin',
        })
      end

      local function jj_diff()
        fzf.fzf_exec('jj diff --name-only', {
          prompt = 'JJ Diff> ',
          actions = { ['default'] = actions.file_edit },
          previewer = 'builtin',
        })
      end

      vim.keymap.set('n', '<leader>?', fzf.oldfiles, { desc = '[?] Find recently opened files' })
      vim.keymap.set('n', '<leader><space>', fzf.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sr', jj_files, { desc = '[S]earch Files [R]epo' })
      vim.keymap.set('n', '<leader>sc', jj_diff, { desc = '[S]earch Files in [C]hange' })
      vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sG', function()
        fzf.live_grep({ cwd = vim.fn.expand('%:p:h') })
      end, { desc = '[S]earch by [G]rep in Current Directory' })
      vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
    end
  },
}
