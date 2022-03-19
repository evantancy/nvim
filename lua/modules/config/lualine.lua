return function()
	local lualine = safe_require("lualine")
	if not lualine then
		return
	end

	lualine.setup({
		options = {
			icons_enabled = true,
			theme = "gruvbox_dark",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {},
			always_divide_middle = true,
			-- REQUIRES neovim >=0.7
			globalstatus = false,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = {},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {},
	})
end
