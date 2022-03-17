" Helpers
function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Plugins
call plug#begin('~/.config/nvim/vim-plug')
Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
Plug 'jremmen/vim-ripgrep'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'morhetz/gruvbox'
Plug 'TovarishFin/vim-solidity'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()
" Lua files
lua require('lsp')

" Colorscheme
colorscheme gruvbox
set background=dark

" Plugin Configs
" ripgrep
if executable('rg')
    let g:rg_derive_root='true'
endif
" CTRL P
let g:ctrlp_user_command=['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching=0
" vim-solidity
" prevent errors when using with vim-polyglot
"let g:polyglot_disabled = ['solidity']

syntax on
set encoding=UTF-8
set clipboard+=unnamedplus
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
" set undodir=~/.nvim/undodir
" set undofile
set incsearch
set colorcolumn=80
set relativenumber
set mouse=a

" Key remappings
let mapleader=" "
if exists('g:vscode')
  source $HOME/.config/nvim/vscode-settings.vim
endif

" Binding CTRL+S, CTRL+Q for save/quit
nnoremap <C-s> :w<CR>
nnoremap <C-q> :wq!<CR>
" Exit insert mode whenever you type 'jk' or 'kj'
inoremap kj <ESC>
inoremap jk <ESC>

" easymotion
map <Leader><Leader> <Plug>(easymotion-prefix)
" navigation
nnoremap <leader>e <C-i><CR>
nnoremap <leader>q <C-o><CR>
nnoremap <leader>h <C-w>h<CR>
nnoremap <leader>j <C-w>j<CR>
nnoremap <leader>k <C-w>k<CR>
nnoremap <leader>l <C-w>l<CR>
nnoremap <leader>ps :Rg<SPACE>
"nnoremap <silent> <Leader>+ :vertical resize +5<CR>
"nnoremap <silent> <Leader>- :vertical resize -5<CR>
" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
"nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
" Telescop
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>dl <cmd>Telescope diagnostics<cr>
" YouCompleteMe
"nnoremap <silent> <leader>gd :YcmCompleter GoTo<CR>
"nnoremap <silent> <leader>gd :YcmCompleter FixIt<CR>
