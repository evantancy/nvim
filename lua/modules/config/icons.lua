return function()
	local icons = safe_require("nvim-web-devicons")
	if not icons then
		return
	end

	icons.setup({
		override = {
			sol = {
				icons = "ﲹ",
				name = "sol",
			},
		},
	})
end
