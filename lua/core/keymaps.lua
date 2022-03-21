-- Leader
vim.g.mapleader = " "

local opts = { noremap = true }
local expr_opts = { noremap = true, expr = true }

map("n", "<c-c>", "<esc>", opts)
-- binding ctrl+s, ctrl+q for save/quit
map("n", "<c-s>", "<cmd>w<cr>", opts)
map("n", "<c-q>", "<cmd>q!<cr>", opts)
map("n", "<c-w>", "<cmd>bw<cr>", opts)
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

map("v", "<c-_>", "<cmd> lua require('Comment.api').toggle_current_linewise()")
-- MAGIC
-- D copies highlighted text
map("v", "D", "y'>p", opts)
-- tab while code selected
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- move hightlighted text up/down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- map("v", "K", ":co '><CR>V'[=gv", opts)

-- navigate buffer
map("n", "<tab>", "<cmd>bnext<cr>", opts)
map("n", "<s-tab>", "<cmd>bprevious<cr>", opts)
-- map("n", "<space>b", "<cmd>b <c-d>", opts)
-- map("n", "<space>b", "<cmd>ls<cr>:b<space>", opts)

-- splits
map("n", "<c-h>", "<c-w>h")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-l>", "<c-w>l")

-- nvim-tree
map("n", "<c-n>", "<cmd>lua require('nvim-tree').toggle(false, false)<cr>", opts)

-- Telescope | ff -> find file | fg -> find grep | fb -> find buffer
-- Telescope | dl -> diagnostics list | fa -> find all
map("n", "<space>vrc", "<cmd>lua require('core.utils').search_dotfiles()<cr>")
map("n", "<space>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map("n", "<space>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
map("n", "<space>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map("n", "<space>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
map("n", "<space>fd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
map("n", "<space>fa", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)

-- -- ripgrep
-- map("n", "<space>ps", " :Rg<space>", opts)
