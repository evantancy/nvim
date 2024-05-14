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
Plug 'loctvl842/monokai-pro.nvim',
Plug 'navarasu/onedark.nvim',
Plug 'simrat39/symbols-outline.nvim',             Cond (!exists('g:vscode')),
" Icons
Plug 'ryanoasis/vim-devicons',                    Cond (!exists('g:vscode')),
Plug 'kyazdani42/nvim-web-devicons',              Cond (!exists('g:vscode')),
" File tree
Plug 'kyazdani42/nvim-tree.lua',                  Cond (!exists('g:vscode')),
" Startup screen
Plug 'goolord/alpha-nvim',                        Cond (!exists('g:vscode')),
" Jump around quickly
Plug 'justinmk/vim-sneak',                        Cond (!exists('g:vscode')),
Plug 'folke/which-key.nvim',                      Cond (!exists('g:vscode')),
" Telescope and deps
Plug 'nvim-lua/plenary.nvim',                     Cond (!exists('g:vscode')),
Plug 'nvim-telescope/telescope-fzf-native.nvim',  Cond (!exists('g:vscode'),  { 'do': 'make' })
Plug 'nvim-telescope/telescope.nvim',             Cond (!exists('g:vscode')),
Plug 'nvim-lua/popup.nvim',                       Cond (!exists('g:vscode')),
Plug 'nvim-telescope/telescope-media-files.nvim', Cond (!exists('g:vscode')),
" LSP
Plug 'VonHeikemen/lsp-zero.nvim',                 Cond (!exists('g:vscode')),
" AI Autocomplete
Plug 'github/copilot.vim',                        Cond (!exists('g:vscode'))
" Plug 'tzachar/cmp-tabnine',                       Cond (!exists('g:vscode'), { 'do': './install.sh' })
Plug 'zbirenbaum/copilot-cmp',                    Cond (!exists('g:vscode')),
Plug 'neovim/nvim-lspconfig',                     Cond (!exists('g:vscode')),
Plug 'williamboman/mason.nvim',                   Cond (!exists('g:vscode')),
Plug 'williamboman/mason-lspconfig.nvim',         Cond (!exists('g:vscode')),
Plug 'jose-elias-alvarez/null-ls.nvim',           Cond (!exists('g:vscode')),
Plug 'hrsh7th/nvim-cmp',                          Cond (!exists('g:vscode')),
Plug 'hrsh7th/cmp-nvim-lua',                      Cond (!exists('g:vscode')),
Plug 'hrsh7th/cmp-nvim-lsp',                      Cond (!exists('g:vscode')),
Plug 'hrsh7th/cmp-buffer',                        Cond (!exists('g:vscode')),
Plug 'hrsh7th/cmp-path',                          Cond (!exists('g:vscode')),
Plug 'hrsh7th/cmp-cmdline',                       Cond (!exists('g:vscode')),
Plug 'hrsh7th/cmp-nvim-lsp-signature-help',       Cond (!exists('g:vscode')),
Plug 'L3MON4D3/LuaSnip',                          Cond (!exists('g:vscode')),
Plug 'saadparwaiz1/cmp_luasnip',                  Cond (!exists('g:vscode')),
Plug 'onsails/lspkind-nvim',                      Cond (!exists('g:vscode')),
" Language specific LSP plugins
" Solidity
Plug 'TovarishFin/vim-solidity',                  Cond (!exists('g:vscode')),
Plug 'jose-elias-alvarez/typescript.nvim',        Cond (!exists('g:vscode')),
" LSP colors
Plug 'folke/lsp-colors.nvim',                     Cond (!exists('g:vscode')),
" Highlighting current symbol
Plug 'RRethy/vim-illuminate',                     Cond (!exists('g:vscode')),
" Formatters
Plug 'jose-elias-alvarez/null-ls.nvim',           Cond (!exists('g:vscode'), {'branch': 'main'}),
" Autocompletion plugin
" AI autocomplete
Plug 'nvim-lua/plenary.nvim',                     Cond (!exists('g:vscode')),
" Autocomplete comments/tags/brackets
Plug 'tpope/vim-surround',                        Cond (!exists('g:vscode')),
Plug 'tpope/vim-repeat',                          Cond (!exists('g:vscode')),
" Autocomplete functions
Plug 'tpope/vim-endwise',                         Cond (!exists('g:vscode')),
Plug 'tpope/vim-sleuth',                          Cond (!exists('g:vscode')),
" Autocomplete HTML tags
Plug 'windwp/nvim-ts-autotag',                    Cond (!exists('g:vscode')),
" Autocomplete bracket pairs
Plug 'windwp/nvim-autopairs',                     Cond (!exists('g:vscode')),
" Auto indent blanklines
Plug 'lukas-reineke/indent-blankline.nvim',       Cond (!exists('g:vscode')),
" Git
" Plug 'tpope/vim-fugitive',
" Git Diff files
Plug 'sindrets/diffview.nvim',                    Cond (!exists('g:vscode')),
" Git in signcolumn
Plug 'lewis6991/gitsigns.nvim',                   Cond (!exists('g:vscode')),
Plug 'airblade/vim-gitgutter',                    Cond (!exists('g:vscode')),
" Comments
Plug 'numToStr/Comment.nvim',                     Cond (!exists('g:vscode')),
" Highlighter
Plug 'nvim-treesitter/nvim-treesitter',           Cond (!exists('g:vscode')),
" Bufferline
Plug 'akinsho/nvim-bufferline.lua',               Cond (!exists('g:vscode')),
" Statusline
Plug 'nvim-lualine/lualine.nvim',                 Cond (!exists('g:vscode')),
" Speed
Plug 'ThePrimeagen/harpoon',                      Cond (!exists('g:vscode')),
" Visualize undo trees
Plug 'mbbill/undotree',                           Cond (!exists('g:vscode')),
" Display hex color codes
Plug 'RRethy/vim-hexokinase',                     Cond (!exists('g:vscode'), {'do': 'make hexokinase'})
" enhanced cpp highlighting
Plug 'octol/vim-cpp-enhanced-highlight',          Cond (!exists('g:vscode')),
" colorize bracket pairs
Plug 'luochen1990/rainbow',                       Cond (!exists('g:vscode')),
" easy align things
Plug 'junegunn/vim-easy-align',                   Cond (!exists('g:vscode')),
" latex preview
Plug 'xuhdev/vim-latex-live-preview',             Cond (!exists('g:vscode'), { 'for': 'tex' })
Plug 'rmagatti/auto-session',                     Cond (!exists('g:vscode'))
" diagnostics
Plug 'folke/trouble.nvim',                        Cond (!exists('g:vscode')),
Plug 'folke/todo-comments.nvim',                  Cond (!exists('g:vscode')),
Plug 'ray-x/lsp_signature.nvim',                  Cond (!exists('g:vscode')),
" Plug 'ThePrimeagen/refactoring.nvim'
call plug#end()

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
command! FormatBuffer :lua vim.lsp.buf.format()
command! PyLspPostSetup :PylspInstall pylsp-rope
