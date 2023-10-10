local status, hexokinase = pcall(require, 'hexokinase')
if not status then
    return
end
vim.g.Hexokinase_highlighers = { 'virtual ' }
-- vim.g.Hexokinase_optInPatterns = {
--     'full_hex',
--     'rgb',
--     'rgba',
--     'hsl',
--     'hsla',
--     'colour_names'
-- }
vim.g.Hexokinase_ftEnabled = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'css',
    'scss',
    'html',
    'yaml',
    'markdown',
    'solidity',
    'lua',
}
