return {
  'dyng/ctrlsf.vim',
  config = function()
    vim.keymap.set('n', '<leader>ff', '<Plug>CtrlSFPrompt', { desc = 'CtrlSFPrompt' })
    vim.keymap.set('v', '<leader>ff', '<Plug>CtrlSFVwordPath', { desc = 'CtrlSFVwordPath' })
    vim.keymap.set('n', '<leader>fw', '<Plug>CtrlSFCwordPath<CR>', { desc = 'CtrlSFCwordPath' })
    vim.keymap.set('n', '<leader>ft', ':CtrlSFToggle<CR>', { desc = 'CtrlSFToggle' })

    vim.g.ctrlsf_backend='/home/ahal/.var/app/io.neovim.nvim/data/nvim/ripgrep.nvim/rg'
  end
}
