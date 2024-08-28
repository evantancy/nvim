local status, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
    return
end

nvim_treesitter.setup({
    highlight = {
        enable = not vim.g.vscode, -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
        -- disable = { 'json' }, -- list of language that will be disabled
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
    },
    indent = { enable = true },
    autopairs = { enable = true },
    rainbow = { enable = true },
    autotag = { enable = true },
    context_commentstring = { enable = true },
    -- A list of parser names, or "all"
    ensure_installed = { 'c', 'lua', 'vim',  'cpp', 'python', 'typescript', 'go', 'gomod', 'gosum'},
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
})
