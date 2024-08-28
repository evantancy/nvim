if vim.g.vscode then
    return
end
local status, indent_blankline = pcall(require, 'ibl')
if not status then
    return
end
vim.opt.list = true
vim.opt.listchars:append('eol:↴')
vim.opt.listchars:append('space:⋅')
indent_blankline.setup()
