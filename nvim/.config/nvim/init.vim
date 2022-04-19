function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')
" Colorschemes
Plug 'rebelot/kanagawa.nvim',
Plug 'ellisonleao/gruvbox.nvim',
Plug 'haishanh/night-owl.vim',
Plug 'folke/tokyonight.nvim',
" LSP colors
Plug 'folke/lsp-colors.nvim',
" Icons
Plug 'ryanoasis/vim-devicons',
Plug 'kyazdani42/nvim-web-devicons',
" File tree
Plug 'kyazdani42/nvim-tree.lua',
" Startup screen
Plug 'goolord/alpha-nvim',
" Jump around quickly
Plug 'easymotion/vim-easymotion',
Plug 'asvetliakov/vim-easymotion',  { 'as': 'vsc-easymotion' }
Plug 'folke/which-key.nvim',
" Telescope and deps
Plug 'nvim-lua/plenary.nvim',
Plug 'nvim-telescope/telescope.nvim',
Plug 'nvim-telescope/telescope-fzf-native.nvim',  { 'do': 'make' }
Plug 'nvim-lua/popup.nvim',
Plug 'nvim-telescope/telescope-media-files.nvim',
" Solidity
Plug 'TovarishFin/vim-solidity',
" LSP
Plug 'neovim/nvim-lspconfig',
Plug 'williamboman/nvim-lsp-installer',
Plug 'jose-elias-alvarez/null-ls.nvim',
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils',
Plug 'RRethy/vim-illuminate',
" Formatters
Plug 'jose-elias-alvarez/null-ls.nvim',  {'branch': 'main'}
" Autocompletion plugin
Plug 'hrsh7th/nvim-cmp',
Plug 'hrsh7th/cmp-nvim-lua',
Plug 'hrsh7th/cmp-nvim-lsp',
Plug 'hrsh7th/cmp-buffer',
Plug 'hrsh7th/cmp-path',
Plug 'hrsh7th/cmp-cmdline',
Plug 'hrsh7th/cmp-nvim-lsp-signature-help',
Plug 'L3MON4D3/LuaSnip',
Plug 'saadparwaiz1/cmp_luasnip',
Plug 'onsails/lspkind-nvim',
" AI autocomplete
Plug 'tzachar/cmp-tabnine',  { 'do': './install.sh' }
Plug 'nvim-lua/plenary.nvim',
" Autocomplete comments/tags/brackets
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Autocomplete functions
Plug 'tpope/vim-endwise'
" Autocomplete HTML tags
Plug 'windwp/nvim-ts-autotag'
" Autocomplete bracket pairs
Plug 'windwp/nvim-autopairs',
" Auto indent blanklines
Plug 'lukas-reineke/indent-blankline.nvim',
" I love you tpope <3
Plug 'tpope/vim-fugitive',
" Diff files
Plug 'sindrets/diffview.nvim',
" Git in signcolumn
Plug 'lewis6991/gitsigns.nvim',
" Comments
Plug 'numToStr/Comment.nvim', {'tag': 'v0.6'}
" Highlighter
Plug 'nvim-treesitter/nvim-treesitter'
" Bufferline
Plug 'akinsho/nvim-bufferline.lua',
" Statusline
Plug 'nvim-lualine/lualine.nvim',
" Speed
Plug 'ThePrimeagen/harpoon',
" Markdown
Plug 'iamcco/markdown-preview.nvim',  { 'do': 'cd app && yarn install'  }
" Visualize undo trees
Plug 'mbbill/undotree',
" Display hex color codes
Plug 'RRethy/vim-hexokinase',  { 'do': 'make hexokinase' }
call plug#end()

lua require('core.utils')
lua require('modules')
lua require('core.keymaps')
lua require('core.autocmd')
lua require('core.options')
