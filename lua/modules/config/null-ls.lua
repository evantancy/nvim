return function()
	local null_ls = safe_require("null-ls")
	if not null_ls then
		return
	end
	local b = null_ls.builtins
	null_ls.setup({
		sources = {
			b.formatting.prettierd.with({ filetypes = { "solidity" } }),
			b.formatting.prettier.with({
				filetypes = {
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
				extra_args = { "" },
			}),
			b.formatting.black.with({ extra_args = { "--fast" } }),
			b.formatting.gofmt,
			b.formatting.shfmt,
			b.formatting.clang_format,
			b.formatting.cmake_format,
			b.formatting.rustywind,
			b.formatting.stylua,
			b.formatting.isort,
			b.diagnostics.tsc,
			b.diagnostics.flake8,
			b.diagnostics.markdownlint,
			b.diagnostics.shellcheck,
			b.code_actions.gitsigns,
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
