-- [[ Setting options ]]
-- See `:help vim.o`

-- General
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'  -- Set completeopt to have a better completion experience
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.showtabline = 2

-- Tabbing
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

-- Python
vim.g.python3_host_prog = "/home/ahal/.virtualenvs/neovim/bin/python"

-- Key maps
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({'n', 'v'}, '<leader>;', '<cmd>AerialToggle!<CR>')
vim.keymap.set('n', '<C-Left>', '<cmd>tabp<cr>')
vim.keymap.set('n', '<C-Right>', '<cmd>tabn<cr>')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")                -- move selection down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")                -- move selection up
vim.keymap.set('n', 'J', 'mzJ`z')                           -- keep cursor in-place
vim.keymap.set('n', '<C-d>', '<C-d>zz')                     -- keep cursor in middle
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('x', '<leader>p', '"_dP')                    -- send highlighted word to null register
vim.keymap.set({'n', 'v'}, '<leader>d', '"_d')
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y')              -- yank to system clipboard
vim.keymap.set({'n', 'v'}, '<leader>Y', '"+Y')
vim.keymap.set({'n', 'v'}, '<leader>l', '<C-^>')            -- jump to previous file
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })  -- deals with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)         -- diagnostics
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
vim.keymap.set('x', 'il', 'g_o^')                           -- line text object
vim.keymap.set('o', 'il', ':<C-u>normal vil<CR>')
vim.keymap.set('x', 'al', '$o0')
vim.keymap.set('o', 'al', ':<C-u>normal val<CR>')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Change tab's working directory
vim.api.nvim_create_user_command(
  'TabChangeDir',
  function(opts)
    local name
    name = string.gsub(opts.args, "/$", "")
    if string.find(name, "/") then
      name = name:match(".+/(.*)$")
    end

    vim.cmd('tcd ' .. opts.args)
    vim.cmd('Tabby rename_tab ' .. name)
  end,
  {
    nargs = 1,
    complete = 'dir',
  }
)
vim.cmd("cnoreabbrev tcd TabChangeDir")
