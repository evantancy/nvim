if vim.fn.exists("g:vscode") == 1 then
	require("vscode")
else
	require("core.utils")
	require("modules")
	require("core.keymaps")
	require("core.autocmd")
	require("core.options")
	-- vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
end
