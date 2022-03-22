-- Recursively source changed .lua files in `&runtimepath` <- this is not a typo
-- https://stackoverflow.com/questions/71186816/how-to-set-a-vim-autocmd-for-any-file-in-packpath
vim.cmd([[
  execute 'autocmd BufWritePost {' .. &packpath .. '}/**/*.lua source <afile> | PackerCompile'
]])

-- Highlight text on yank
vim.cmd([[
augroup HighlightYank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 200})
augroup end
]])

-- Autoformat see `null-ls.lua`
vim.cmd([[
augroup LspFormat
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)
augroup end
]])

-- Show diagnostics on hover
vim.cmd([[
  autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
]])

-- Recognise solidity files for prettier's solidity plugin
vim.cmd([[
  au BufNewFile,BufRead *.sol set filetype=solidity
]])

-- Automatically change working directory
-- vim.cmd([[
--   autocmd BufEnter * silent! lcd %:p:h
-- ]])
