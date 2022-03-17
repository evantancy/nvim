-- Leader
vim.g.mapleader = " "

local opts = { noremap = true }
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
-- binding ctrl+s, ctrl+q for save/quit
vim.api.nvim_set_keymap("n", "<c-s>", "<cmd>w<cr>", opts)
vim.api.nvim_set_keymap("n", "<c-q>", "<cmd>wq!<cr>", opts)
-- exit insert mode whenever you type 'jk' or 'kj'
vim.api.nvim_set_keymap("i", "kj", "<esc>", opts)
vim.api.nvim_set_keymap("i", "jk", "<esc>", opts)
-- MAGIC
-- D copies highlighted test
vim.api.nvim_set_keymap("v", "D", "y'>p", opts)
-- tab while code selected
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })

-- navigate buffer
vim.api.nvim_set_keymap("n", "<tab>", "<cmd>bnext<cr>", opts)
vim.api.nvim_set_keymap("n", "<s-tab>", "<cmd>bprevious<cr>", opts)
---- jump list
vim.api.nvim_set_keymap("n", "<leader>e", " <c-i><cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>q", " <c-o><cr>", opts)
---- splits
vim.api.nvim_set_keymap("n", "<c-h>", "<c-w>h", { silent = false })
vim.api.nvim_set_keymap("n", "<c-j>", "<c-w>j", { silent = false })
vim.api.nvim_set_keymap("n", "<c-k>", "<c-w>k", { silent = false })
vim.api.nvim_set_keymap("n", "<c-l>", "<c-w>l", { silent = false })
-- ---- ripgrep
-- vim.api.nvim_set_keymap("n", "<leader>ps", " :Rg<space>", opts)
-- -- NERDTree
-- vim.api.nvim_set_keymap("n", "<c-n>", " :NERDTreeToggle<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>n", " :NERDTreeFocus<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<C-n>", " :NERDTree<CR>", opts)
-- -- Telescope
-- vim.api.nvim_set_keymap("n", "<leader>ff <cmd>Telescope", " find_files<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>fg <cmd>Telescope", " live_grep<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>fb <cmd>Telescope", " buffers<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>fh <cmd>Telescope", " help_tags<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>dl <cmd>Telescope", " diagnostics<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>fa <cmd>Telescope", " lsp_references<cr>", opts)
-- -- YouCompleteMe
-- vim.api.nvim_set_keymap("n", "<silent>", " <leader>gd :YcmCompleter GoTo<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<silent>", " <leader5gd :YcmCompleter FixIt<CR>", opts)

-- -- Telescope
-- vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>dl", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>fa", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
