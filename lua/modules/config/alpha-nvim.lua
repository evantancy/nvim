return function()
	local alpha = safe_require("alpha")
	if not alpha then
		return
	end
	local theme = require("alpha.themes.startify")
	alpha.setup(theme.config)
end
