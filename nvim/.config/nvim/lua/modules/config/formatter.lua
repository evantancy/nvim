local null_ls = safe_require('null-ls')
if not null_ls then
    return
end
local b = null_ls.builtins
local format = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local ca = null_ls.builtins.code_actions
-- Disable inline diagnostics
vim.diagnostic.config({
    virtual_text = true,
})

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
        format.black.with({ extra_args = { '--fast' } }),
        format.gofmt,
        format.shfmt,
        format.clang_format,
        format.cmake_format,
        format.stylua,
        format.isort,
        diagnostics.tsc,
        diagnostics.flake8,
        diagnostics.shellcheck,
        --        diagnostics.sqlfluff.with({
        -- 	extra_args = {"--dialect", "postgres"} -- change to your dialect
        -- })
    },
    on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd([[
		                  augroup LspFormatting
		                      autocmd! * <buffer>
		                      autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
		                  augroup END
		              ]])
        end
    end,
})
