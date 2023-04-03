function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('$XDG_DATA_HOME/.vim/plugged')
" Colorschemes
Plug 'rebelot/kanagawa.nvim',
Plug 'ellisonleao/gruvbox.nvim',
Plug 'haishanh/night-owl.vim',
Plug 'folke/tokyonight.nvim',
Plug 'loctvl842/monokai-pro.nvim'
Plug 'navarasu/onedark.nvim'
" Icons
Plug 'ryanoasis/vim-devicons',
Plug 'kyazdani42/nvim-web-devicons',
" File tree
Plug 'kyazdani42/nvim-tree.lua',
" Startup screen
Plug 'goolord/alpha-nvim',
" Jump around quickly
Plug 'justinmk/vim-sneak'
Plug 'folke/which-key.nvim',
" Telescope and deps
Plug 'nvim-lua/plenary.nvim',
Plug 'nvim-telescope/telescope-fzf-native.nvim',  { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim',
Plug 'nvim-lua/popup.nvim',
Plug 'nvim-telescope/telescope-media-files.nvim',
" LSP
Plug 'VonHeikemen/lsp-zero.nvim',
Plug 'tzachar/cmp-tabnine',  { 'do': './install.sh' }
Plug 'neovim/nvim-lspconfig',
Plug 'williamboman/mason.nvim',
Plug 'williamboman/mason-lspconfig.nvim',
Plug 'jose-elias-alvarez/null-ls.nvim',
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
" Language specific LSP plugins
" Solidity
Plug 'TovarishFin/vim-solidity',
" TODO use typescript.nvim
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils',
" LSP colors
Plug 'folke/lsp-colors.nvim',
" Highlighting current symbol
Plug 'RRethy/vim-illuminate',
" Formatters
Plug 'jose-elias-alvarez/null-ls.nvim',  {'branch': 'main'}
" Autocompletion plugin
" AI autocomplete
Plug 'nvim-lua/plenary.nvim',
" Autocomplete comments/tags/brackets
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Autocomplete functions
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth'
" Autocomplete HTML tags
Plug 'windwp/nvim-ts-autotag'
" Autocomplete bracket pairs
Plug 'windwp/nvim-autopairs',
" Auto indent blanklines
Plug 'lukas-reineke/indent-blankline.nvim',
" Git
" Plug 'tpope/vim-fugitive',
" Git Diff files
Plug 'sindrets/diffview.nvim',
" Git in signcolumn
Plug 'lewis6991/gitsigns.nvim',
" Comments
Plug 'numToStr/Comment.nvim',
" Highlighter
Plug 'nvim-treesitter/nvim-treesitter',
" Bufferline
Plug 'akinsho/nvim-bufferline.lua',
" Statusline
Plug 'nvim-lualine/lualine.nvim',
" Speed
Plug 'ThePrimeagen/harpoon',
" Visualize undo trees
Plug 'mbbill/undotree',
" Display hex color codes
Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}
" enhanced cpp highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
" colorize bracket pairs
Plug 'luochen1990/rainbow'
" easy align things
Plug 'junegunn/vim-easy-align'
" latex preview
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'rmagatti/auto-session'

call plug#end()

lua require('utils')
lua require('core')
lua require('modules')

"set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1

" enhanced cpp highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_concepts_highlight = 1
let g:sneak#label = 1

" latex preview stuff
let g:livepreview_previewer = 'evince' " built-in for linux
let g:livepreview_engine = 'lualatex'
" let g:livepreview_engine = 'lualatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error -pdf -output-directory=%OUTDIR% %DOC%'
let g:livepreview_cursorhold_recompile = 0

" wipe registers
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
" close all but current buffer
command! CloseAllButCurrent %bd|e#|bd#
" create snapshot of plugins
command! SnapshotPugins PlugSnapshot! $DOTFILES/nvim/snapshots/plug.snapshot
" Quick fix stuff
command! QuickFixClear call setqflist([],'r')
command! QuickFixUndo cdo :norm! u
