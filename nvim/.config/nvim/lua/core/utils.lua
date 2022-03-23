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
	vim.api.nvim_set_keymap(mode, shortcut, action, opts or { silent = False })
end

-- buf map keys
function _G.buf_map(bufnr, mode, shortcut, action, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, action, opts or { silent = False })
end

function _G.info()
	local version = vim.version()
	local nvim_version_info = " v" .. version.major .. "." .. version.minor .. "." .. version.patch
	return nvim_version_info
end

-- see if a file exists
function _G.file_exists(file)
	local f = io.open(file, "rb")
	if f then
		f:close()
	end
	return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function _G.get_lines_from(file)
	if not file_exists(file) then
		return {}
	end
	local lines = {}
	for line in io.lines(file) do
		lines[#lines + 1] = line
	end
	return lines
end

-- custom functions
M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = "~/.dotfiles/",
		hidden = true,
	})
end

-- M.grep_dotfiles = function()
-- 	require("telescope.builtin").live_grep({
-- 		prompt_title = "< VimRC Live Grep >",
-- 		cwd = "~/.dotfiles/",
-- 		search_dirs = "~/.dotfiles/*",
-- 	})
-- end

return M
