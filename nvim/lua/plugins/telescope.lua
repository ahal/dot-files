return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-live-grep-args.nvim', version = "^1.0.0"
      }
    },
    config = function()
      require('telescope').load_extension('live_grep_args')
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
}
