-- Recursively source changed .lua files in `&runtimepath` <- this is not a typo
-- https://stackoverflow.com/questions/71186816/how-to-set-a-vim-autocmd-for-any-file-in-packpath
-- vim.cmd([[
--   execute 'autocmd BufWritePost {' .. &packpath .. '}/**/*.lua source <afile> | PackerCompile'
-- ]])

-- -- clear all registers on launch
-- vim.cmd([[
-- autocmd VimEnter * WipeReg
-- ]])

-- Highlight text on yank
vim.cmd([[
augroup HighlightYank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 150})
augroup end
]])

-- Autoformat see `null-ls.lua`
vim.cmd([[
augroup LspFormat
  autocmd! * <buffer>
  autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
augroup end
]])

-- Show diagnostics on hover
-- vim.cmd([[
--   autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
-- ]])

-- Recognise file type(s)
vim.cmd([[
  au BufNew,BufNewFile,BufRead *.sol set filetype=solidity
  au BufNew,BufNewFile,BufRead *.json set filetype=jsonc
]])

-- Only enable highlights during search
vim.cmd([[
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    " autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
]])
-- Automatically change working directory
-- vim.cmd([[
--   autocmd BufEnter * silent! lcd %:p:h
-- ]])

-- Disable automatic comment insertion
vim.cmd([[
    autocmd FileType * setlocal formatoptions-=c formatoptions+=r formatoptions-=o
]])

-- silence `Press Enter ...` confirmations for fugitive
vim.cmd([[
  function! s:ftplugin_fugitive() abort
    nnoremap <buffer> <silent> cc :Git commit --quiet<CR>
    nnoremap <buffer> <silent> ca :Git commit --quiet --amend<CR>
    nnoremap <buffer> <silent> ce :Git commit --quiet --amend --no-edit<CR>
  endfunction
  augroup nhooyr_fugitive
    autocmd!
    autocmd FileType fugitive call s:ftplugin_fugitive()
  augroup END
]])
