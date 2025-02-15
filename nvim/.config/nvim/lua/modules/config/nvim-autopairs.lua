local status, nvim_autopairs = pcall(require, 'nvim-autopairs')
if not status then
    return
end
nvim_autopairs.setup({
    disable_filetype = { 'TelescopePrompt' },
    disable_in_macro = false, -- disable when recording or executing a macro
    disable_in_visualblock = false, -- disable when insert after visual block mode
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
    enable_moveright = true,
    enable_afterquote = true, -- add bracket pairs after quote
    enable_check_bracket_line = true, --- check bracket in same line
    check_ts = false,
    map_bs = true, -- map the <BS> key
    map_c_h = false, -- Map the <C-h> key to delete a pair
    map_c_w = false, -- map <c-w> to delete a pair if possible
})
