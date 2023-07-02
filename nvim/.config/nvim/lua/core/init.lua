--------------------------- AUTO COMMANDS ----------------------------------
--------------------------- AUTO COMMANDS ----------------------------------
--------------------------- AUTO COMMANDS ----------------------------------

-- ---- Auto indent on empty line.
-- vim.keymap.set('n', 'i', function()
--     return string.match(vim.api.nvim_get_current_line(), '%g') == nil and 'cc' or 'i'
-- end, { expr = true, noremap = true })

-- Recursively source changed .lua files in `&runtimepath` <- this is not a typo
-- https://stackoverflow.com/questions/71186816/how-to-set-a-vim-autocmd-for-any-file-in-packpath
-- vim.cmd([[
--   execute 'autocmd BufWritePost {' .. &packpath .. '}/**/*.lua source <afile> | PackerCompile'
-- ]])

-- clear all registers on launch
-- vim.cmd([[ autocmd VimEnter * WipeReg ]])

-- Highlight text on yank
vim.cmd([[
augroup HighlightOnYank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 150})
augroup end
]])

-- Autoformat see `null-ls.lua`
vim.cmd([[
augroup LspFormatBeforeWrite
  autocmd! * <buffer>
  autocmd BufWritePre * lua vim.lsp.buf.format()
augroup end
]])

-- Show diagnostics on hover
-- vim.cmd([[
--   autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
-- ]])

-- Recognise file type(s)
vim.cmd([[
  au BufNew,BufNewFile,BufRead *.sol set filetype=solidity
  au BufNew,BufNewFile,BufRead *.json set filetype=jsonc
]])

-- Only enable highlights during search
-- vim.cmd([[
-- augroup HighlightDuringIncsearch
--     autocmd!
--     autocmd CmdlineEnter /,\? :set hlsearch
--     autocmd CmdlineLeave /,\? :set nohlsearch
-- augroup END
-- ]])

-- Automatically change working directory
-- vim.cmd([[
--   autocmd BufEnter * silent! lcd %:p:h
-- ]])

-- Disable automatic comment insertion, except when pressing Enter
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

--------------------------- REMAPS ----------------------------------
--------------------------- REMAPS ----------------------------------
--------------------------- REMAPS ----------------------------------

-- Leader
vim.g.mapleader = ' '

function map(mode, shortcut, action, opts)
    vim.api.nvim_set_keymap(mode, shortcut, action, opts or { silent = False })
end

local opts = { noremap = true }
local expr_opts = { noremap = true, expr = true }

vim.keymap.set({ 'n', 'x' }, '<leader>s', 'zt<Plug>Sneak_s')
vim.keymap.set({ 'n', 'x' }, '<leader>S', 'zb<Plug>Sneak_S')
vim.keymap.set('n', '<C-c>', '<Esc>')

-- allow single line travel when lines visually wrap
if vim.g.vscode then
    -- navigate around wrapped lines
    vim.keymap.set('n', 'k', 'gk')
    vim.keymap.set('n', 'j', 'gj')

    -- navigate buffer
    vim.keymap.set('n', '<tab>', '<cmd>call VSCodeNotify("workbench.action.nextEditor")<CR>')
    vim.keymap.set('n', '<s-tab>', '<cmd>call VSCodeNotify("workbench.action.previousEditor")<CR>')

    -- shifting lines in visual mode
    vim.keymap.set('x', 'K', ":move '<-2<CR>gv-gv")
    vim.keymap.set('x', 'J', ":move '>+1<CR>gv-gv")

    -- split navigation
    vim.keymap.set('n', 'sh', '<cmd>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
    vim.keymap.set('n', 'sj', '<cmd>call VSCodeNotify("workbench.action.navigateDown")<CR>')
    vim.keymap.set('n', 'sk', '<cmd>call VSCodeNotify("workbench.action.navigateUp")<CR>')
    vim.keymap.set('n', 'sl', '<cmd>call VSCodeNotify("workbench.action.navigateRight")<CR>')

    -- split window management
    vim.keymap.set('n', 'ss', '<cmd>call VSCodeNotify("workbench.action.splitEditorDown")<cr>', { silent = true, desc = '[s]plit s??' })
    vim.keymap.set('n', 'sv', '<cmd>call VSCodeNotify("workbench.action.splitEditorRight")<cr>', { silent = true, desc = '[s]plit [v]ertically' })
    vim.keymap.set(
        'n',
        'sc',
        '<cmd>call VSCodeNotify("workbench.action.closeEditorsInOtherGroups")<cr>',
        { silent = true, desc = '[s]plit [c]lose, all other splits but active split' }
    )

    -- nvim-tree
    vim.keymap.set('n', '<c-n>', '<cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<cr>', { silent = true })

    -- telescope
    vim.keymap.set('n', '<leader>ff', '<cmd>call VSCodeNotify("workbench.action.quickOpen")<cr>', { silent = true })
    vim.keymap.set('n', '<leader>fo', '<cmd>call VSCodeNotify("workbench.action.openRecent")<cr>', { silent = true })

    -- Comment.nvim
    vim.keymap.set('n', 'gc', '<cmd>call VSCodeNotify("editor.action.commentLine")<cr>', { desc = 'Normal mode line comment' })
    vim.keymap.set('x', 'gc', '<cmd>call VSCodeNotifyVisual("editor.action.commentLine", 0)<cr>', { desc = 'Visual mode line comment' })
    vim.keymap.set('n', 'gbc', '<cmd>call VSCodeNotify("editor.action.blockComment")<cr>', { desc = 'Normal mode block comment' })
    vim.keymap.set('x', 'gb', '<cmd>call VSCodeNotifyVisual("editor.action.blockComment", 0)<cr>', { desc = 'Visual mode block comment' })

    -- EXTRAS
    vim.keymap.set('n', '<leader>', '<Nop>')
    vim.keymap.set('x', '<leader>', '<Nop>')

    -- NOTE LSP, see lsp.lua
    vim.keymap.set('n', 'K', '<cmd>call VSCodeNotify("editor.action.showHover")<cr>', { desc = 'Show Hover' })
    vim.keymap.set('n', 'gr', '<cmd>call VSCodeNotify("editor.action.referenceSearch.trigger")<cr>', { desc = '[G]oto [r]eferences' })
    vim.keymap.set('n', 'gd', '<cmd>call VSCodeNotify("editor.action.peekDefinition")<cr>', { desc = ' [ G]oto [d]efinition' })
    vim.keymap.set('n', 'gD', '<cmd>call VSCodeNotify("editor.action.peekDeclaration")<cr>', { desc = ' [ G]oto [D]eclaration' })
    vim.keymap.set('n', 'gt', '<cmd>call VSCodeNotify("editor.action.peekTypeDefinition")<cr>', { desc = ' [ G]oto [t]ype definition' })
    vim.keymap.set('n', 'gi', '<cmd>call VSCodeNotify("editor.action.peekImplementation")<cr>', { desc = ' [ G]oto [i]mplementation' })
    -- vim.keymap.set('n', '<c-h>', '<cmd>call VSCodeNotify("editor.action.showHover")<cr>', { desc = ' Show signature [h]elp' })
    -- vim.keymap.set('n', '<space>rn', '<cmd>call VSCodeNotify("editor.action.showHover")<cr>', { desc = ' [ r]e[n]ame' })
    -- vim.keymap.set({ 'x' }, '<space>ca', '<cmd>call VSCodeNotify("editor.action.showHover")<cr>', { desc = '[c]ode [a]ctions' })
    vim.keymap.set('n', '<space>fm', '<cmd>call VSCodeNotifyVisual("editor.action.formatSelection", 0)<cr>', { desc = '[f]or[m]at' })
else
    -- navigate around wrapped lines
    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

    -- navigate buffer
    vim.keymap.set('n', '<tab>', '<cmd>bnext<cr>', opts)
    vim.keymap.set('n', '<s-tab>', '<cmd>bprevious<cr>', opts)

    -- shifting lines in visual mode
    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

    -- split navigation
    vim.keymap.set('n', 'sh', '<C-w>h', opts)
    vim.keymap.set('n', 'sj', '<C-w>j', opts)
    vim.keymap.set('n', 'sk', '<C-w>k', opts)
    vim.keymap.set('n', 'sl', '<C-w>l', opts)

    -- split window management
    vim.keymap.set('n', 'ss', ':split<CR><C-w>w', { silent = true, desc = '[s]plit s??' })
    vim.keymap.set('n', 'sv', ':vsplit<CR><C-w>w', { silent = true, desc = '[s]plit [v]ertically' })
    vim.keymap.set('n', 'sc', '<c-w>o<cr>', { silent = true, desc = '[s]plit [c]lose, all other splits but active split' })

    -- nvim-tree
    vim.keymap.set('n', '<c-n>', "<cmd>lua require('nvim-tree').toggle()<cr>", opts)

    -- telescope
    vim.keymap.set('n', '<leader>ff', function()
        require('telescope.builtin').find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })
    end)
    vim.keymap.set('n', '<leader>fo', function()
        require('telescope.builtin').oldfiles(require('telescope.themes').get_dropdown({}))
    end)

    -- Comment.nvim
    -- ctrl+/ or ctrl+\ to line/block comment
    local comment_status, comment = pcall(require, 'Comment')
    if comment_status then
        vim.keymap.set('n', '<c-/>', require('Comment.api').toggle.linewise.current, { desc = 'Normal mode line comment' })
        vim.keymap.set('n', '<c-bslash>', require('Comment.api').toggle.blockwise.current, { desc = 'Normal mode block comment' })
        -- VISUAL MODE COMMENTS
        vim.keymap.set('x', '<c-/>', function()
            require('Comment.api').toggle.linewise(vim.fn.visualmode())
        end, { desc = 'Visual only line comment' })
        vim.keymap.set('x', '<c-bslash>', function()
            require('Comment.api').toggle.blockwise(vim.fn.visualmode())
        end, { desc = 'visual only block comment' })
    end
end

-- replace currently selected text with default register without yanking
vim.keymap.set('v', 'p', '"_dP', opts)
vim.keymap.set('n', '<leader>D', '"_D', opts)
vim.keymap.set('n', '<leader>C', '"_C', opts)
vim.keymap.set('n', '<leader>c', '"_c', opts)
vim.keymap.set('n', '<leader>x', '"_x', opts)

-- prompt for a refactor to apply when the remap is triggered
-- vim.api.nvim_set_keymap('v', '<leader>rr', ":lua require('refactoring').select_refactor()<CR>", { noremap = true, silent = true, expr = false })

-- Telescope | ff -> find file | fg -> find grep | fb -> find buffer
-- Telescope | dl -> diagnostics list | fa -> find all
vim.keymap.set('n', '<leader>vrc', function()
    require('telescope.builtin').find_files({
        prompt_title = '< VimRC Find Files >',
        cwd = '$DOTFILES',
        hidden = true,
    })
end)
vim.keymap.set('n', '<leader>vrg', function()
    require('telescope.builtin').live_grep({
        prompt_title = '< VimRC Live Grep >',
        cwd = '$DOTFILES',
    })
end)

-- Trouble
vim.keymap.set('n', '<leader>t', function()
    require('trouble').toggle({ auto_preview = false })
end)

-- FIXME why format not working
-- vim.keymap.set({ 'v'}, '<leader>fm', function() vim.lsp.buf.format() end)
vim.keymap.set('n', '<leader>fg', function()
    require('telescope.builtin').live_grep()
end)
vim.keymap.set('n', '<leader>fb', function()
    require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({}))
end)
vim.keymap.set('n', '<leader>fh', function()
    require('telescope.builtin').help_tags()
end)
vim.keymap.set('n', '<leader>fd', function()
    require('telescope.builtin').diagnostics()
end)
vim.keymap.set('n', '<leader>wk', function()
    require('telescope.builtin').keymaps()
end)
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        previewer = true,
    }))
end, { desc = '[/] Fuzzily search in current buffer' })

-- navigate TODO items
vim.keymap.set('n', ']t', function()
    require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })

vim.keymap.set('n', '[t', function()
    require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

-- diagnostics
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Open [E]rror in float' })
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = 'Goto prev [d]iagnostic' })
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = 'Goto next [d]iagnostic' })
vim.keymap.set('n', '[c', function()
    require('gitsigns').prev_hunk()
end, { desc = 'Goto prev [c]hange' })
vim.keymap.set('n', ']c', function()
    require('gitsigns').next_hunk()
end, { desc = 'Goto next [c]hange' })
vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- move hightlighted text up/down
vim.keymap.set('n', '<leader>j', ':m .+1<CR>==', opts)
vim.keymap.set('n', '<leader>k', ':m .-2<CR>==', opts)
-- FIXME possibly causes some bug inside vscode, see https://github.com/vscode-neovim/vscode-neovim/issues/1187
vim.keymap.set('i', '<c-j>', '<esc>:m .+1<CR>==gi', opts)
vim.keymap.set('i', '<c-k>', '<esc>:m .-2<CR>==gi', opts)

-- toggle ignorecase
vim.keymap.set('n', '<F2>', '<cmd>set ignorecase! ignorecase?<cr>')
vim.keymap.set('n', '<c-c>', '<esc>', opts)
-- exit insert mode whenever you type 'jk' or 'kj'
vim.keymap.set('i', 'kj', '<esc>', opts)
vim.keymap.set('i', 'jk', '<esc>', opts)
-- delete without yanking
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

-- make vim behave properly, like c & C, d & D
vim.keymap.set('n', 'Y', 'y$', opts)
-- set scroll=10 <- being overridden by something so set 10 manually here
vim.keymap.set('n', '<C-d>', '10<C-d>zz')
vim.keymap.set('n', '<C-u>', '10<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
-- maintain cursor at current position when joining lines
vim.keymap.set('n', '<leader>J', 'mzJ`z', opts)
-- break undo sequence using punctuation marks
vim.keymap.set('i', ',', ',<c-g>u', opts)
vim.keymap.set('i', '.', '.<c-g>u', opts)
vim.keymap.set('i', '!', '!<c-g>u', opts)
vim.keymap.set('i', '?', '?<c-g>u', opts)

-- make vim behave
-- D duplicates highlighted text below
vim.keymap.set('v', 'D', "y'>p", opts)
-- tab while code selected
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Harpoon
vim.keymap.set('n', '<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<cr>", { desc = '[h]arpoon [a]dd' })
vim.keymap.set('n', '<leader>hs', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", { desc = '[h]arpoon [s]how' })
-- not really sure what this does atm
-- vim.keymap.set('n', '<leader>ht', "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>", { desc = '[h]arpoon [t]oggle' })
vim.keymap.set('n', '<A-1>', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
vim.keymap.set('n', '<A-2>', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
vim.keymap.set('n', '<A-3>', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
vim.keymap.set('n', '<A-4>', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
-- undotree
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<cr>')

-- resize windows
-- TODO fix for MacOS
vim.keymap.set('n', '<C-left>', '<C-w><', opts)
vim.keymap.set('n', '<C-right>', '<C-w>>', opts)
vim.keymap.set('n', '<C-up>', '<C-w>+', opts)
vim.keymap.set('n', '<C-down>', '<C-w>-', opts)

-- moving around in vim commandline
vim.keymap.set('c', '<c-h>', '<left>')
vim.keymap.set('c', '<c-j>', '<down>')
vim.keymap.set('c', '<c-k>', '<up>')
vim.keymap.set('c', '<c-l>', '<right>')
vim.keymap.set('c', '^', '<home>')
vim.keymap.set('c', '$', '<end>')

-- quickfix list
vim.keymap.set('n', ']q', ':cnext<cr>')
vim.keymap.set('n', '[q', ':cprev<cr>')

-- increment/decrement
vim.keymap.set('n', '+', '<c-a>')
vim.keymap.set('n', '_', '<c-x>')

-- vim.keymap.set('n', 's')

--------------------------- REMAPS ----------------------------------
--------------------------- REMAPS ----------------------------------
--------------------------- REMAPS ----------------------------------

local api = vim.api
local g = vim.g
local opt = vim.opt
local o = vim.o

-- vim.opt.statusline = status_line()
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

-- Enable syntax highlighting
vim.cmd([[
	syntax on
    set undodir=$XDG_DATA_HOME/.vim/undodir
    set undofile
]])

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
-- opt.textwidth = 80 -- Wrap lines at column 80
opt.colorcolumn = '80' -- Show column
opt.linebreak = true -- Break by word, not character
opt.ruler = true
opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.termguicolors = true
opt.splitbelow = true -- Horizontal splits will automatically be below
opt.splitright = true -- Vertical splits will automatically be to the right
vim.cmd([[set scroll=10]])
opt.scrolloff = 10 -- Keep X lines above/below cursor when scrolling
opt.cursorline = true -- Show cursor position all the time
-- opt.cursorlineopt = 'number,screenline' -- disable highlighting the entire line
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
opt.updatetime = 750 -- Faster autocomplete
opt.timeoutlen = 750 -- Reduce timeoutlen

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
