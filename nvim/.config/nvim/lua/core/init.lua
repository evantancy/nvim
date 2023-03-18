--------------------------- AUTO COMMANDS ----------------------------------
--------------------------- AUTO COMMANDS ----------------------------------
--------------------------- AUTO COMMANDS ----------------------------------

-- Recursively source changed .lua files in `&runtimepath` <- this is not a typo
-- https://stackoverflow.com/questions/71186816/how-to-set-a-vim-autocmd-for-any-file-in-packpath
-- vim.cmd([[
--   execute 'autocmd BufWritePost {' .. &packpath .. '}/**/*.lua source <afile> | PackerCompile'
-- ]])

-- clear all registers on launch
vim.cmd([[
autocmd VimEnter * WipeReg
]])

-- Highlight text on yank
vim.cmd([[
augroup HighlightYank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 150})
augroup end
]])

-- Autoformat see `null-ls.lua`
vim.cmd([[
augroup LspFormat
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
augroup end
]])

-- Show diagnostics on hover
vim.cmd([[
  autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
]])

-- Recognise file type(s)
vim.cmd([[
  au BufNew,BufNewFile,BufRead *.sol set filetype=solidity
  au BufNew,BufNewFile,BufRead *.json set filetype=jsonc
]])

-- Only enable highlights during search
vim.cmd([[
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    " autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
]])
-- Automatically change working directory
-- vim.cmd([[
--   autocmd BufEnter * silent! lcd %:p:h
-- ]])

-- Disable automatic comment insertion
vim.cmd([[
    autocmd FileType * setlocal formatoptions-=c formatoptions+=r formatoptions-=o
]])

-- silence `Press Enter ...` confirmations for fugitive
vim.cmd([[
  function! s:ftplugin_fugitive() abort
    nnoremap <buffer> <silent> cc :Git commit --quiet<CR>
    nnoremap <buffer> <silent> ca :Git commit --quiet --amend<CR>
    nnoremap <buffer> <silent> ce :Git commit --quiet --amend --no-edit<CR>
  endfunction
  augroup nhooyr_fugitive
    autocmd!
    autocmd FileType fugitive call s:ftplugin_fugitive()
  augroup END
]])

--------------------------- AUTO COMMANDS ----------------------------------
--------------------------- AUTO COMMANDS ----------------------------------
--------------------------- AUTO COMMANDS ----------------------------------

-- Leader
vim.g.mapleader = ' '

local opts = { noremap = true }
local expr_opts = { noremap = true, expr = true }

if vim.g.vscode then
    -- inside vscode

    -- allow single line travel when lines visually wrap
    map('n', 'k', 'gk')
    map('n', 'j', 'gj')

    -- navigate buffer
    map('n', '<tab>', '<cmd>call VSCodeNotify("workbench.action.nextEditor")<cr>', opts)
    map('n', '<s-tab>', '<cmd>call VSCodeNotify("workbench.action.previousEditor")<cr>', opts)
    -- splits
    map('n', 'sh', '<cmd>call VSCodeNotify("workbench.action.navigateLeft")<cr>')
    map('n', 'sj', '<cmd>call VSCodeNotify("workbench.action.navigateDown")<cr>')
    map('n', 'sk', '<cmd>call VSCodeNotify("workbench.action.navigateUp")<cr>')
    map('n', 'sl', '<cmd>call VSCodeNotify("workbench.action.navigateRight")<cr>')
    -- nvim-tree
    map('n', '<C-n>', "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<cr>", opts)

    -- see `lsp.lua`
    map('n', 'K', '<cmd>call VSCodeNotify("editor.action.showHover")<cr>')
    map('n', 'gd', '<cmd>call VSCodeNotify("editor.action.revealDefinition")<cr>')
    map('n', 'gr', '<cmd>call VSCodeNotify("editor.action.goToReferences")<cr>')
else
    -- inside vim

    -- allow single line travel when lines visually wrap
    map('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
    map('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

    -- navigate buffer
    map('n', '<tab>', '<cmd>bnext<cr>', opts)
    map('n', '<s-tab>', '<cmd>bprevious<cr>', opts)
    -- splits
    map('n', 'sh', '<c-w>h')
    map('n', 'sj', '<c-w>j')
    map('n', 'sk', '<c-w>k')
    map('n', 'sl', '<c-w>l')
    -- nvim-tree
    map('n', '<c-n>', "<cmd>lua require('nvim-tree').toggle()<cr>", opts)

    -- Comment.nvim
    -- ctrl+/ or ctrl+\ to line/block comment
    vim.keymap.set('n', '<c-_>', "<cmd> lua require('Comment.api').toggle.linewise.current()<cr>")
    vim.keymap.set('n', '<c-bslash>', "<cmd> lua require('Comment.api').toggle.blockwise.current()<cr>")
    -- VISUAL MODE COMMENTS
    vim.keymap.set('x', '<c-_>', "<cmd> lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")
    vim.keymap.set('x', '<c-bslash>', "<cmu> lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>")

    -- Telescope | ff -> find file | fg -> find grep | fb -> find buffer
    -- Telescope | dl -> diagnostics list | fa -> find all
    map('n', '<space>vrc', "<cmd>lua require('core.utils').search_dotfiles()<cr>")
    map('n', '<space>vrg', "<cmd>lua require('core.utils').grep_dotfiles()<cr>")
    map('n', '<space>ff', "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>", opts)
    map('n', '<space>fo', "<cmd>lua require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown({}))<cr>", opts)
    map('n', '<space>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
    map('n', '<space>fb', "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({}))<cr>", opts)
    map('n', '<space>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
    map('n', '<space>fd', "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
    map('n', '<space>fa', "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
    vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
            previewer = true,
        }))
    end, { desc = '[/] Fuzzily search in current buffer' })
end
-- split window
map('n', 'ss', ':split<CR><C-w>w', { silent = true })
map('n', 'sv', ':vsplit<CR><C-w>w', { silent = true })

-- diagnostics
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- move hightlighted text up/down
map('n', '<space>j', ':m .+1<CR>==', opts)
map('n', '<space>k', ':m .-2<CR>==', opts)
map('i', '<c-j>', '<esc>:m .+1<CR>==gi', opts)
map('i', '<c-k>', '<esc>:m .-2<CR>==gi', opts)
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- toggle ignorecase
map('n', '<F2>', '<cmd>set ignorecase! ignorecase?<cr>')
map('n', '<c-c>', '<esc>', opts)
-- exit insert mode whenever you type 'jk' or 'kj'
map('i', 'kj', '<esc>', opts)
map('i', 'jk', '<esc>', opts)
-- delete without yanking
vim.keymap.set({ 'n', 'v' }, '<space>d', '"_d')
map('n', '<space>D', '"_D', opts)
map('n', '<space>C', '"_C', opts)
map('n', '<space>c', '"_c', opts)
map('n', 'x', '"_x', opts)

--  replace currently selected text with default register without yanking
map('v', 'p', '"_dP', opts)

-- wtf?????????????????????????????????????????????????????????????????????
map('n', 'Y', 'y$', opts)
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('n', '<space>J', 'mzJ`z', opts)
-- break undo sequence using punctuation marks
map('i', ',', ',<c-g>u', opts)
map('i', '.', '.<c-g>u', opts)
map('i', '!', '!<c-g>u', opts)
map('i', '?', '?<c-g>u', opts)

-- make vim behave
-- D duplicates highlighted text below
map('v', 'D', "y'>p", opts)
-- tab while code selected
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Harpoon
map('n', '<leader>a', "<cmd>lua require('harpoon.mark').add_file()<cr>")
map('n', '<leader>h', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
map('n', '<leader>tc', "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>")
map('n', '<A-1>', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
map('n', '<A-2>', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
map('n', '<A-3>', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
map('n', '<A-4>', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
-- undotree
map('n', '<space>u', '<cmd>UndotreeToggle<cr>')

local api = vim.api
local g = vim.g
local opt = vim.opt
local o = vim.o
local function status_line()
    local mode = '%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}'
    local file_name = '%-.16t'
    local buf_nr = '[%n]'
    local modified = ' %-m'
    local file_type = ' %y'
    local right_align = '%='
    local line_no = '%10([%l/%L%)]'
    local pct_thru_file = '%5p%%'

    return string.format('%s%s%s%s%s%s%s%s', mode, file_name, buf_nr, modified, file_type, right_align, line_no, pct_thru_file)
end

-- vim.opt.statusline = status_line()

-- Enable syntax highlighting
vim.cmd([[
	syntax on
    set undodir=$XDG_DATA_HOME/.vim/undodir
    set undofile
]])

api.nvim_set_hl(0, 'CursorLine', { underline = true })
-- Aesthetics
opt.title = true
opt.signcolumn = 'yes' -- Keep gutter even without LSP screaming
opt.winblend = 0
opt.wildoptions = 'pum'
opt.pumheight = 8 -- Popup menu height
opt.pumblend = 20 -- Popup menu transparency
opt.cmdheight = 1
opt.wrap = true -- Wrap lines
opt.wrapmargin = 0 -- Margin space when wrapping
opt.textwidth = 100 -- Wrap lines at column 80
opt.colorcolumn = '100' -- Show column
opt.linebreak = true -- Break by word, not character
opt.ruler = true
opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.termguicolors = true
opt.splitbelow = true -- Horizontal splits will automatically be below
opt.splitright = true -- Vertical splits will automatically be to the right
opt.scroll = 10
opt.scrolloff = 10 -- Keep X lines above/below cursor when scrolling
opt.cursorline = true -- Show cursor position all the time
opt.cursorlineopt = 'number,screenline' -- disable highlighting the entire line
-- Backups
opt.swapfile = false
opt.writebackup = false
opt.backup = false

-- Tabs and Indentation
opt.smarttab = true
opt.autoindent = true
opt.smartcase = true
opt.smartindent = true
opt.breakindent = true
opt.expandtab = true -- Tabs to spaces
opt.tabstop = 4 -- Number of spaces for tab
opt.softtabstop = 4
opt.shiftwidth = 4 -- Number of spaces for indentation
opt.virtualedit = 'block' -- Allow rectangular selections, see https://medium.com/usevim/vim-101-virtual-editing-661c99c05847

-- Utility
opt.clipboard = 'unnamedplus' -- Share clipboard between Vim and system
opt.mouse = 'a' -- Enable mouse
opt.errorbells = false -- Disable annoying sounds
opt.iskeyword = opt.iskeyword + '-' -- Treat dash separated words as a word text object
opt.incsearch = true -- Searching
opt.hlsearch = true -- Searching
opt.inccommand = 'nosplit' -- Enable preview result of incsearch
-- opt.wildignore = { '.git/*', 'node_modules/*' }
opt.wildignorecase = true
-- Align with autocmd.lua
opt.formatoptions = opt.formatoptions
    + {
        c = false,
        o = false, -- o and O don't continue comments
        r = true, -- Pressing Enter will continue comments
    }
opt.ignorecase = true
opt.smartcase = true
-- -- Disable automatic comment insertion
-- vim.cmd([[
--     autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
-- ]])

-- Speed
opt.updatetime = 50 -- Faster autocomplete
opt.timeoutlen = 500 -- Reduce timeoutlen

-- -- Shortmess
opt.shortmess = opt.shortmess
    + {
        A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
        I = true, -- don't give the intro message when starting Vim |:intro|.
        W = true, -- don't give "written" or "[w]" when writing a file
        c = true, -- don't give |ins-completion-menu| messages
        m = true, -- use "[+]" instead of "[Modified]"
    }

-- Remove builtin plugins
g.netrw_dirhistmax = 0
g.loaded_2html_plugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logipat = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_rrhelper = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
