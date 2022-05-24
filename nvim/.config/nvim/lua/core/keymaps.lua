-- Leader
vim.g.mapleader = ' '

local opts = { noremap = true }
local expr_opts = { noremap = true, expr = true }

if vim.g.vscode then
    -- Current behaviour in vscode:
    -- buffer navigation using tab / s-tab
    -- comments using Comment.nvim
    -- file tree navigation

    -- inside vscode

    -- allow single line travel when lines visually wrap
    map('n', 'k', 'gk')
    map('n', 'j', 'gj')

    map('n', '<tab>', '<cmd>call VSCodeNotify("workbench.action.nextEditor")<cr>', opts)
    map('n', '<s-tab>', '<cmd>call VSCodeNotify("workbench.action.previousEditor")<cr>', opts)
    -- splits
    map('n', '<C-h>', '<cmd>call VSCodeNotify("workbench.action.navigateLeft")<cr>')
    map('n', '<C-j>', '<cmd>call VSCodeNotify("workbench.action.navigateDown")<cr>')
    map('n', '<C-k>', '<cmd>call VSCodeNotify("workbench.action.navigateUp")<cr>')
    map('n', '<C-l>', '<cmd>call VSCodeNotify("workbench.action.navigateRight")<cr>')
    -- nvim-tree
    map('n', '<C-n>', "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<cr>", opts)

    -- see `lsp.lua`
    map('n', 'K', '<cmd>call VSCodeNotify("editor.action.showHover")<cr>')
    map('n', 'gd', '<cmd>call VSCodeNotify("editor.action.revealDefinition")<cr>')
    map('n', 'gr', '<cmd>call VSCodeNotify("editor.action.goToReferences")<cr>')
else
    -- inside vim

    -- allow single line travel when lines visually wrap
    map('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
    map('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

    -- navigate buffer
    map('n', '<tab>', '<cmd>bnext<cr>', opts)
    map('n', '<s-tab>', '<cmd>bprevious<cr>', opts)
    -- splits
    map('n', '<c-h>', '<c-w>h')
    map('n', '<c-j>', '<c-w>j')
    map('n', '<c-k>', '<c-w>k')
    map('n', '<c-l>', '<c-w>l')
    -- nvim-tree
    map('n', '<c-n>', "<cmd>lua require('nvim-tree').toggle()<cr>", opts)

    -- Comment.nvim
    -- ctrl+/ or ctrl+\ to line/block comment
    map('n', '<c-_>', "<cmd> lua require('Comment.api').toggle_current_linewise()<cr>")
    map('n', '<c-bslash>', "<cmd> lua require('Comment.api').toggle_current_blockwise()<cr>")
    -- VISUAL MODE COMMENTS
    map('x', '<c-_>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
    map('x', '<c-bslash>', '<ESC><CMD>lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())<CR>')

    -- Telescope | ff -> find file | fg -> find grep | fb -> find buffer
    -- Telescope | dl -> diagnostics list | fa -> find all
    map('n', '<space>vrc', "<cmd>lua require('core.utils').search_dotfiles()<cr>")
    map('n', '<space>vrg', "<cmd>lua require('core.utils').grep_dotfiles()<cr>")
    map('n', '<space>ff', "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>", opts)
    map('n', '<space>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
    map('n', '<space>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
    map('n', '<space>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
    map('n', '<space>fd', "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
    map('n', '<space>fa', "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
end

-- diagnostics
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- move hightlighted text up/down
map('n', '<space>j', ':m .+1<CR>==', opts)
map('n', '<space>k', ':m .-2<CR>==', opts)
map('i', '<c-j>', '<esc>:m .+1<CR>==gi', opts)
map('i', '<c-k>', '<esc>:m .-2<CR>==gi', opts)
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- toggle ignorecase
map('n', '<F2>', '<cmd>set ignorecase! ignorecase?<cr>')
map('n', '<c-c>', '<esc>', opts)
-- exit insert mode whenever you type 'jk' or 'kj'
map('i', 'kj', '<esc>', opts)
map('i', 'jk', '<esc>', opts)
-- delete without yanking
map('n', '<space>d', '"_d', opts)
map('v', '<space>d', '"_d', opts)
--  replace currently selected text with default register without yanking
map('v', 'p', '"_dP', opts)
map('n', '<space>x', '"_dx', opts)

-- wtf?????????????????????????????????????????????????????????????????????
map('n', 'Y', 'y$', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('n', '<space>J', 'mzJ`z', opts)
map('i', ',', ',<c-g>u', opts)
map('i', '.', '.<c-g>u', opts)
map('i', '!', '!<c-g>u', opts)
map('i', '?', '?<c-g>u', opts)

-- make vim behave
-- D copies highlighted text
map('v', 'D', "y'>p", opts)
-- tab while code selected
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)
-- map("n", "<space>b", "<cmd>b <c-d>", opts)
-- map("n", "<space>b", "<cmd>ls<cr>:b<space>", opts)

-- Harpoon
map('n', '<leader>a', "<cmd>lua require('harpoon.mark').add_file()<cr>")
map('n', '<leader>h', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
map('n', '<leader>tc', "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>")
map('n', '<A-1>', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
map('n', '<A-2>', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
map('n', '<A-3>', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
map('n', '<A-4>', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")
-- undotree
map('n', '<space>u', '<cmd>UndotreeToggle<cr>')
