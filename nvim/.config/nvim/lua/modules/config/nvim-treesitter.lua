local nvim_treesitter = safe_require('nvim-treesitter.configs')
if not nvim_treesitter then
    return
end

nvim_treesitter.setup({
    highlight = {
        enable = not vim.g.vscode, -- false will disable the whole extension
        additional_vim_regex_highlighting = true,
        -- disable = { 'json' }, -- list of language that will be disabled
    },
    indent = { enable = true },
    autopairs = { enable = true },
    rainbow = { enable = true },
    autotag = { enable = true },
    context_commentstring = { enable = true },
    ensure_installed = {'c', 'help', 'lua', 'vim', 'cpp', 'python', 'typescript'}
})
