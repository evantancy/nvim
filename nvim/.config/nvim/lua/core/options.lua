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
    set undodir=~/.vim/undodir
    set undofile
]])

-- Aesthetics
opt.signcolumn = 'yes' -- Keep gutter even without LSP screaming
opt.pumheight = 8 -- Popup menu height
opt.pumblend = 20 -- Popup menu transparency
opt.cmdheight = 1
opt.wrap = true -- Wrap lines
opt.wrapmargin = 0 -- Margin space when wrapping
opt.textwidth = 0 -- Wrap lines at column 80
opt.colorcolumn = '80' -- Show column
opt.linebreak = true -- Break by word, not character
opt.ruler = true
opt.number = true -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.termguicolors = true
opt.splitbelow = true -- Horizontal splits will automatically be below
opt.splitright = true -- Vertical splits will automatically be to the right
opt.scrolloff = 10 -- Keep X lines above/below cursor when scrolling
opt.cursorline = true -- Show cursor position all the time
opt.cursorlineopt = 'number' -- disable highlighting the entire line

-- Backups
opt.swapfile = false
opt.writebackup = false
opt.backup = false

-- Tabs and Indentation
opt.smarttab = true
opt.autoindent = true
opt.smartcase = true
opt.smartindent = true
opt.expandtab = true -- Tabs to spaces
opt.tabstop = 4 -- Number of spaces for tab
opt.softtabstop = 4
opt.shiftwidth = 4 -- Number of spaces for indentation

-- Utility
opt.clipboard = 'unnamed' -- Share clipboard between Vim and system
opt.mouse = 'a' -- Enable mouse
opt.errorbells = false -- Disable annoying sounds
opt.iskeyword = opt.iskeyword + '-' -- Treat dash separated words as a word text object
opt.incsearch = true -- Searching

-- Speed
opt.updatetime = 50 -- Faster autocomplete
opt.timeoutlen = 500 -- Reduce timeoutlen

-- -- Shortmess
-- o.shortmess = o.shortmess
-- 	+ {
-- 		A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
-- 		I = true, -- don't give the intro message when starting Vim |:intro|.
-- 		W = true, -- don't give "written" or "[w]" when writing a file
-- 		c = true, -- don't give |ins-completion-menu| messages
-- 		m = true, -- use "[+]" instead of "[Modified]"
-- 	}

-- Format options
vim.cmd([[set formatoptions-=cro]])

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
