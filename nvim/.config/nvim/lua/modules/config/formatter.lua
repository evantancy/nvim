local status, null_ls = pcall(require, 'null-ls')
if not status then
    return
end
local b = null_ls.builtins
local format = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local ca = null_ls.builtins.code_actions
-- Disable inline diagnostics
if not vim.g.vscode then
    vim.diagnostic.config(
        {
            virtual_text = {
                severity_sort = true,
                severity = {
                    min = vim.diagnostic.severity.WARN,
                },
                source = 'always',
            },
        }
        -- opts = {
        --     -- options for vim.diagnostic.config()
        --     diagnostics = {
        --         underline = true,
        --         update_in_insert = false,
        --         virtual_text = {
        --             spacing = 4,
        --             source = "if_many",
        --             prefix = "●",
        --             -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        --             -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        --             -- prefix = "icons",
        --         },
        --         severity_sort = true,
        -- }}
    )
end

null_ls.setup({
    sources = {
        format.prettier.with({
            extra_args = { '--print-width=100' },
            filetypes = {
                'solidity',
                'javascript',
                'javascriptreact',
                'typescript',
                'typescriptreact',
                'vue',
                'css',
                'scss',
                'less',
                'html',
                'json',
                'jsonc',
                'yaml',
                'markdown',
                'graphql',
            },
        }),
        format.black.with({ extra_args = { '--fast', '--line-length 80' } }),
        format.isort,
        format.gofmt,
        format.shfmt.with({
            extra_args = { '-i', '2', '-sr', '-s', '-ci' },
            filetypes = { 'bash', 'csh', 'ksh', 'sh', 'zsh' },
        }),
        format.clang_format,
        format.cmake_format,
        format.stylua,
        diagnostics.tsc,
        diagnostics.shellcheck,
        --        diagnostics.sqlfluff.with({
        -- 	extra_args = {"--dialect", "postgres"} -- change to your dialect
        -- })
    },
})
