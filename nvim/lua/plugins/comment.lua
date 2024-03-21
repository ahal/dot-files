return {
  {
    'numToStr/Comment.nvim', -- "gc" to comment visual regions/lines
    config = function()
      require('Comment').setup()
    end
  },
  { 'tpope/vim-commentary' },
}
