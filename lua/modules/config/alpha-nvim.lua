return function()
	local alpha = safe_require("alpha")
	if not alpha then
		return
	end

	local function info()
		local version = vim.version()
		local nvim_version_info = " v" .. version.major .. "." .. version.minor .. "." .. version.patch
		return nvim_version_info
	end

	local theme = require("alpha.themes.startify")

	theme.section.header.val = {
		[[NEOVIM]] .. info(),
	}

	theme.section.top_buttons.val = {
		theme.button("e", "New file", ":ene <BAR> startinsert <CR>"),
		theme.button("f", "Find file", "<cmd>lua require('telescope.builtin').find_files()<cr>"),
		theme.button("q", "Quit NVIM", ":qa<CR>"),
	}
	-- Shift buttons to only top_buttons
	theme.section.bottom_buttons.val = {}
	theme.section.footer = {}

	theme.nvim_web_devicons.enabled = true
	-- options: true, 'Keyword'
	theme.nvim_web_devicons.highlight = true

	-- https://github.com/goolord/alpha-nvim/issues/14
	-- theme.opts.layout = {
	-- 	{ type = "padding", val = 1 },
	-- 	theme.section.header,
	-- 	{ type = "padding", val = 1 },
	-- 	theme.section.top_buttons,
	-- 	theme.section.mru_cwd,
	-- 	theme.section.mru,
	-- 	theme.section.bottom_buttons,
	-- 	theme.section.footer,
	-- }

	alpha.setup(theme.config)
end
