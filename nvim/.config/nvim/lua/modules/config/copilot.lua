return function()
	local copilot = safe_require("copilot")
	-- vim.cmd([[imap <silent><script><expr> <C-L> copilot#Accept("\<CR>")]])
	-- vim.g.copilot_no_tab_map = true
	-- vim.g.copilot_filetypes = {
	-- 	["*"] = true,
	-- 	gitcommit = false,
	-- 	NeogitCommitMessage = false,
	-- }
end
