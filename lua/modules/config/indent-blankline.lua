return function()
	local indent_blankline = safe_require("indent_blankline")
	if not indent_blankline then
		return
	end
	vim.opt.list = true
	vim.opt.listchars:append("eol:↴")
	indent_blankline.setup({
		buftype_exclude = { "terminal" },
		filetype_exclude = { "help", "NvimTree", "dashboard", "packer", "TelescopePrompt" },
		show_current_context = true,
		show_current_context_start = true,
		space_char_blankline = " ",
		show_end_of_line = true,
		use_treesitter = true,
	})
end
