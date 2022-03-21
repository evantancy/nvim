-- Leader key
vim.g.mapleader = " "
local opts = { noremap = true }
local expr_opts = { noremap = true, expr = true }
local opt = vim.opt

-- ??
opt.rtp:remove(vim.fn.stdpath("data") .. "/site")
opt.rtp:remove(vim.fn.stdpath("data") .. "/site/after")
vim.cmd([[let &packpath = &runtimepath]])
-- vim.cmd [[silent! packadd vim-surround]]

-- Options
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.virtualedit = "block"
opt.clipboard = "unnamedplus"
opt.iskeyword = opt.iskeyword + "-"

-- Keymaps
map("n", "<c-c>", "<esc>", opts)
-- binding ctrl+s, ctrl+q for save/quit
-- map("n", "<c-s>", "<cmd>w<cr>", opts)
-- map("n", "<c-q>", "<cmd>q!<cr>", opts)
map("n", "<c-w>", '<cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<cr>', opts)
-- exit insert mode whenever you type 'jk' or 'kj'
map("i", "kj", "<esc>", opts)
map("i", "jk", "<esc>", opts)
-- allow single line travel when lines visually wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
-- delete without yanking
map("n", "<space>d", '"_d', opts)
map("v", "<space>d", '"_d', opts)
--  replace currently selected text with default register without yanking
map("v", "p", '"_dP', opts)

-- MAGIC
-- D copies highlighted text
map("v", "D", "y'>p", opts)
-- tab while code selected
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- move hightlighted text up/down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- navigate buffer
map("n", "<tab>", '<cmd>call VSCodeNotify("workbench.action.nextEditor")<cr>')
map("n", "<s-tab>", '<cmd>call VSCodeNotify("workbench.action.previousEditor")<cr>')

-- splits
map("n", "<C-h>", '<cmd>call VSCodeNotify("workbench.action.navigateLeft")<cr>')
map("n", "<C-j>", '<cmd>call VSCodeNotify("workbench.action.navigateDown")<cr>')
map("n", "<C-k>", '<cmd>call VSCodeNotify("workbench.action.navigateUp")<cr>')
map("n", "<C-l>", '<cmd>call VSCodeNotify("workbench.action.navigateRight")<cr>')

-- nvim-tree
map("n", "<c-n>", '<cmd>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<cr>', opts)

map("n", "K", '<cmd>call VSCodeNotify("editor.action.showHover")<cr>')
map("n", "gd", '<cmd>call VSCodeNotify("editor.action.revealDefinition")<cr>')
map("n", "<C-w>gd", '<cmd>call VSCodeNotify("editor.action.revealDefinitionAside")<cr>')
map("n", "gr", '<cmd>call VSCodeNotify("editor.action.goToReferences")<cr>')
-- map('n', '<space>qf', '<cmd>call VSCodeNotify("editor.action.quickFix")<cr>')

-- Comments
-- comment.nvim
map("v", "gc", '<cmd>call VSCodeNotify("editor.action.commentLine")<cr>')
map("n", "gcc", '<cmd>call VSCodeNotify("editor.action.commentLine")<cr>')
map("v", "gbc", '<cmd>call VSCodeNotify("editor.action.blockComment")<cr>')

-- General
-- map("n", "<space>.", '<cmd>call VSCodeNotify("workbench.action.openSettingsJson")<cr>')
-- map("n", "<space>;", '<cmd>call VSCodeNotify("workbench.action.showCommands")<cr>')
-- map("n", "<space>z", '<cmd>call VSCodeNotify("workbench.action.toggleZenMode")<cr>')

-- Open
-- map("n", "<space>od", '<cmd>call VSCodeNotify("workbench.action.files.openFolder")<cr>')
-- map("n", "<space>or", '<cmd>call VSCodeNotify("workbench.action.openRecent")<cr>')

vim.cmd([[
  augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 200})
augroup end
]])
