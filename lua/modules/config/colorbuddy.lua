return function()
	local colorbuddy = safe_require("colorbuddy")
	if not colorbuddy then
		return
	end

	colorbuddy.setup()
end
