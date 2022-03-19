-- Recursively source changed .lua files in `&runtimepath` <- this is not a typo
-- https://stackoverflow.com/questions/71186816/how-to-set-a-vim-autocmd-for-any-file-in-packpath
vim.cmd([[
  execute 'autocmd BufWritePost {' .. &packpath .. '}/**/*.lua source <afile> | PackerCompile'
]])

-- Highlight text on yank
vim.cmd([[
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 200})
augroup end
]])

-- Autoformat
vim.cmd([[
augroup format_on_save
  au!
  au BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 2000)
augroup end
]])
--[[ " when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

let g:prettier#autoformat = 0
autocmd BufWritePre,TextChanged,InsertLeave *.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync ]]
