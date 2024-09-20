return {
  'mfussenegger/nvim-dap',
  dependencies = {
    { 'mfussenegger/nvim-dap-python' },
  },
  config = function()
    require('dap-python').setup('/home/ahal/.virtualenvs/neovim/bin/python')
  end
}
