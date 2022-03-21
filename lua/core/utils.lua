local M = {}

-- function P(cmd)
-- 	print(vim.inspect(cmd))
-- end

-- function _G.is_git_dir()
-- 	return os.execute("git rev-parse --is-inside-work-tree >> /dev/null 2>&1")
-- end

function _G.safe_require(module)
	local ok, result = pcall(require, module)
	if not ok then
		vim.notify(string.format("Error requiring: %s", module), vim.log.levels.ERROR)
		return ok
	end
	return result
end
-- map keys
function _G.map(mode, shortcut, action, opts)
	vim.api.nvim_set_keymap(mode, shortcut, action, opts or { silent = True })
end

-- buf map keys
function _G.buf_map(bufnr, mode, shortcut, action, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, action, opts or { silent = True })
end

-- custom functions
M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = "~/.config/nvim",
	})
end

return M
