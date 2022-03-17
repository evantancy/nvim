return function()
	vim.opt.termguicolors = true
	vim.g.gruvbox_contrast_dark = "hard"
	vim.g.gruvbox_invert_selection = false
	vim.o.background = "dark"
	vim.cmd([[colorscheme gruvbox]])
end
