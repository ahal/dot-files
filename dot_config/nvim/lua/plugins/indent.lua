return {
  {
    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
    config = function()
      -- See `:help indent_blankline.txt`
      require('ibl').setup {
        indent={char = '┊'},
        scope={show_start = false, show_end = false},
      }
    end
  },
  { 'michaeljsmith/vim-indent-object' },
}
