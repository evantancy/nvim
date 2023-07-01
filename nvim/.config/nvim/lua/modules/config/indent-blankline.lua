if vim.g.vscode then
    return
end
local status, indent_blankline = pcall(require, 'indent_blankline')
if not status then
    return
end
vim.opt.list = true
vim.opt.listchars:append('eol:↴')
vim.opt.listchars:append('space:⋅')
indent_blankline.setup({
    buftype_exclude = { 'terminal' },
    filetype_exclude = { 'help', 'NvimTree', 'dashboard', 'packer', 'TelescopePrompt' },
    show_current_context = true,
    show_current_context_start = true,
    space_char_blankline = ' ',
    show_end_of_line = true,
    use_treesitter = false,
})
