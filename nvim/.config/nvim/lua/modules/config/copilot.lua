local status, copilot = pcall(require, 'copilot')
if not status then
    return
end
-- vim.cmd([[imap <silent><script><expr> <C-L> copilot#Accept("\<CR>")]])
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
    ['*'] = true,
    gitcommit = false,
    NeogitCommitMessage = false,
    NvimTree = false
}
