-- Configure nvim-lspconfig and nvim-cmp
return function()
    -- ############################ IMPORTS ###################################
    local lspconfig = safe_require('lspconfig')
    if not lspconfig then
        return
    end

    local cmp_nvim_lsp = safe_require('cmp_nvim_lsp')
    if not cmp_nvim_lsp then
        return
    end
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if cmp_nvim_lsp then
        capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    end

    local cmp = safe_require('cmp')
    if not cmp then
        return
    end

    local cmp_autopairs = safe_require('nvim-autopairs.completion.cmp')
    if not cmp_autopairs then
        return
    end
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

    -- ######################## STANDARD KEYMAPS ##############################
    local opts = { noremap = true }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    local on_attach = function(client, bufnr)
        -- only allow null-ls to format
        if client.name ~= 'null-ls' then
            client.resolved_capabilities.document_formatting = false
            -- client.resolved_capabilities.document_range_formatting = false
        end

        if client.name == 'tsserver' then
            local ts_utils = safe_require('nvim-lsp-ts-utils')
            if not ts_utils then
                return
            end
            ts_utils.setup({})
            ts_utils.setup_client(client)
            -- TODO: fix keymaps that clash
            buf_map(bufnr, 'n', 'gs', ':TSLspOrganize<CR>')
            buf_map(bufnr, 'n', 'gi', ':TSLspRenameFile<CR>')
            buf_map(bufnr, 'n', 'go', ':TSLspImportAll<CR>')
        end
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = {
        'pyright',
        'sumneko_lua',
        'solc',
        -- "solang",
        'solidity_ls',
        'tsserver',
        'clangd',
        'bashls',
        'ansiblels',
        'cmake',
        'cssls',
        'dockerls',
        'emmet_ls',
    }

    for _, lsp in pairs(servers) do
        local server_found, server_instance = require('nvim-lsp-installer').get_server(lsp)
        if server_found and not server_instance:is_installed() then
            server_instance:install()
        end

        -- TODO: config solang
        if server_instance.name == 'solc' then
            -- rely on proper configuration from remappings
            local remappings = get_lines_from('remappings.txt')
            local cmd = { 'solc', '--lsp', unpack(remappings) }
            server_instance:setup({
                cmd = cmd,
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            })
        elseif server_instance.name == 'solang' then
            -- `-m` for linking imports (lib)
            -- `-I` for where your contracts live (src)
            -- https://github.com/hyperledger-labs/solang/issues/705
            -- https://github.com/hyperledger-labs/solang/issues/591
            -- https://github.com/hyperledger-labs/solang/issues/493
            -- local remappings = get_lines_from("remappings.txt")
            local cmd = {
                'solang',
                '--language-server',
                -- "--importmap=openzeppelin=lib/openzeppelin-contracts",
                -- "--importmap base64-sol=base64",
                -- "-I",
                -- "./src",
            }
            server_instance:setup({
                cmd = cmd,
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            })
        else
            --  require('lspconfig')[lsp].setup {
            --    on_attach = on_attach,
            --    cmd_env = server_instance:get_default_options().cmd_env
            --  }
            server_instance:setup({
                on_attach = on_attach,
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            })
        end
    end

    -- Setup nvim-cmp.
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    local lspkind = safe_require('lspkind')
    local source_mapping = {
        buffer = '[Buf]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[Lua]',
        cmp_tabnine = '[TN]',
        path = '[Path]',
        luasnip = '[snip]',
    }
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = {
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
            ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ['<C-y>'] = cmp.config.disable,
            ['<C-c>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },

        -- order determines the priority
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' }, -- only for Lua
            { name = 'cmp_tabnine' },
            { name = 'buffer', keyword_length = 5 },
            { name = 'luasnip' }, -- snippets
            -- { name = "treesitter" },
            { name = 'path' },
        }),
        formatting = {
            format = lspkind.cmp_format({
                with_text = true,
                menu = source_mapping,
            }),
        },
        experimental = {
            -- preview text to be inserted
            ghost_text = true,
        },
    })
    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
        }),
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline('/', {
    -- sources = {
    --   { name = 'buffer' }
    -- }
    -- })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    -- cmp.setup.cmdline(':', {
    -- sources = cmp.config.sources({
    --   { name = 'path' }
    -- }, {
    --   { name = 'cmdline' }
    -- })
    -- })
end
