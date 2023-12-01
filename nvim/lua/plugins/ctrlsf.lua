return {
  'dyng/ctrlsf.vim',
  config = function()
    vim.keymap.set('n', '<leader>sa', '<Plug>CtrlSFPrompt', { desc = '[S]earch [A]cross project' })
  end
}
