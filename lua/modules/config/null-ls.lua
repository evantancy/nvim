return function()
	local null_ls = safe_require("null-ls")
	if not null_ls then
		return
	end
	local b = null_ls.builtins
	local format = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local ca = null_ls.builtins.code_actions
	null_ls.setup({
		sources = {
			format.prettier.with({
				filetypes = {
					"solidity",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"css",
					"scss",
					"less",
					"html",
					"json",
					"jsonc",
					"yaml",
					"markdown",
					"graphql",
				},
				extra_args = {
					"--print-width",
					"80",
					"--trailing-comma",
					"es5",
				},
			}),
			format.black.with({ extra_args = { "--fast" } }),
			format.gofmt,
			format.shfmt,
			format.clang_format,
			format.cmake_format,
			format.rustywind,
			format.stylua,
			format.isort,
			diagnostics.tsc,
			diagnostics.flake8,
			diagnostics.markdownlint,
			diagnostics.shellcheck,
		},
		on_attach = function(client)
			if client.resolved_capabilities.document_formatting then
				vim.cmd([[
                    augroup LspFormatting
                        autocmd! * <buffer>
                        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                    augroup END
                ]])
			end
			-- vim.cmd([[
			--   augroup document_highlight
			--     autocmd! * <buffer>
			--     autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
			--     autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			--   augroup END
			-- ]])
		end,
	})
end
