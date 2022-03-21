return function()
	local nvim_tree = safe_require("nvim-tree")
	if not nvim_tree then
		return
	end
	-- local map = require("nvim-tree.config").nvim_tree_callback

	vim.g.nvim_tree_indent_markers = 0
	nvim_tree.setup({
		update_focused_file = {
			enable = true,
			update_cwd = false,
			ignore_list = {},
		},
		filters = {
			dotfiles = true,
			-- Files to hide
			custom = { ".git" },
		},
		view = {
			width = 30,
			height = 30,
			side = "left",
			hide_root_folder = false,
			auto_resize = false,
			signcolumn = "no",
			mappings = {
				-- `custom_only = false` will merge list of mappings with defaults
				custom_only = true,
				list = {
					{ key = "<c-r>", action = "refresh" },
					{ key = "a", action = "create" },
					{ key = "d", action = "remove" },
					{ key = "<bs>", action = "close_node" },
					{ key = "<cr>", action = "edit" },
					{ key = "<space>r", action = "rename" },
					{ key = "s", action = "split" },
					{ key = "v", action = "vsplit" },
					{ key = "x", action = "cut" },
					{ key = "c", action = "copy" },
					{ key = "p", action = "paste" },
					{ key = "Y", action = "copy_path" },
					{ key = "y", action = "copy_name" },
					{ key = "I", action = "toggle_ignored" },
				},
			},
		},
	})
end
