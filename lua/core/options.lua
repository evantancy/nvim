local api = vim.api
local g = vim.g
local o = vim.opt

-- Enable syntax highlighting
vim.cmd([[ syntax on ]])

-- Aesthetics
o.signcolumn = "yes" -- Keep gutter even without LSP screaming
o.pumheight = 8 -- Popup menu height
o.pumblend = 20 -- Popup menu transparency
o.cmdheight = 1
o.colorcolumn = "80"
o.ruler = true
o.number = true
o.relativenumber = true
o.wrap = false
o.termguicolors = true
o.splitbelow = true -- Horizontal splits will automatically be below
o.splitright = true -- Vertical splits will automatically be to the right
o.scrolloff = 5 -- Keep X lines above/below cursor when scrolling
o.cursorline = true -- Show cursor position all the time

-- Backups
o.swapfile = false
o.writebackup = false
o.backup = false

-- Tabs and Indentation
o.smarttab = true
o.autoindent = true
o.smartcase = true
o.smartindent = true
o.expandtab = true -- Tabs to spaces
o.tabstop = 4 -- Number of spaces for tab
o.softtabstop = 4
o.shiftwidth = 4 -- Number of spaces for indentation

-- Utility
o.clipboard = "unnamedplus" -- Share clipboard between Vim and system
o.mouse = "a" -- Enable mouse
o.errorbells = false -- Disable annoying sounds
o.iskeyword = o.iskeyword + "-" -- Treat dash separated words as a word text object
o.incsearch = true -- Searching

-- Speed
o.updatetime = 300 -- Faster autocomplete
o.timeoutlen = 500 -- Reduce timeoutlen??

-- Format options
o.formatoptions = o.formatoptions
	+ {
		c = false,
		o = false, -- O and o, don't continue comments
		r = true, -- Pressing Enter will continue comments
	}

-- -- Shortmess
-- o.shortmess = o.shortmess
-- 	+ {
-- 		A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
-- 		I = true, -- don't give the intro message when starting Vim |:intro|.
-- 		W = true, -- don't give "written" or "[w]" when writing a file
-- 		c = true, -- don't give |ins-completion-menu| messages
-- 		m = true, -- use "[+]" instead of "[Modified]"
-- 	}

-- Remove builtin plugins
g.netrw_dirhistmax = 0
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_zipPlugin = 1
-- vim.g.loaded_zip = 1
