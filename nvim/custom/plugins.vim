" === Plugins ===
call plug#begin('~/.config/nvim/plugins')
" Motion
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/camelcasemotion'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi'

"Theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'RRethy/nvim-base16'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'dyng/ctrlsf.vim'
Plug 'stevearc/aerial.nvim'
Plug 'folke/trouble.nvim'

" Util
Plug 'nvim-lua/plenary.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'antoinemadec/FixCursorHold.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'windwp/nvim-autopairs'

" Test
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-python'

" Debug
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'

" Firenvim
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

for file in split(glob(Dot("custom/plugins/*.vim")), "\n")
  let name = fnamemodify(file, ":t:r")
  if exists("g:plugs[\"" . name . "\"]")
    exec "source" file
  else
    echom "No plugin found for config file " . file
  endif
endfor
