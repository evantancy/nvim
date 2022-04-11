return function()
    local which_key = safe_require('which-key')
    if not which_key then
        return
    end
    which_key.setup({
        plugins = {
            spelling = {
                suggestions = 10,
            },
        },
    })
end
