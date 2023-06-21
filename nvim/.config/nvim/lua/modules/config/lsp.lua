vim.lsp.set_log_level('off')
local capabilities = vim.lsp.protocol.make_client_capabilities()
local status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status then
    return
end
if cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities()
end

local status, cmp = pcall(require, 'cmp')
if not status then
    return
end
local status, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
if not status then
    return
end
-- local status, refactoring = pcall(require, 'refactoring')
-- if status then
--     refactoring.setup({
--         -- prompt for return type
--         prompt_func_return_type = {
--             go = true,
--             cpp = true,
--             c = true,
--             java = true,
--             python = true,
--         },
--         -- prompt for function parameters
--         prompt_func_param_type = {
--             go = true,
--             cpp = true,
--             c = true,
--             java = true,
--             python = true,
--         },
--     })
-- end

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

local todo_status, todo_comments = pcall(require, 'todo-comments')
todo_comments.setup({
    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
        FIX = {
            icon = ' ', -- icon used for the sign, and in search results
            color = 'error', -- can be a hex color, or a named color (see below)
            alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
        },
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', color = 'warning' },
        WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    },
    gui_style = {
        fg = 'NONE', -- The gui style to use for the fg highlight group.
        bg = 'BOLD', -- The gui style to use for the bg highlight group.
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
        multiline = true, -- enable multine todo comments
        multiline_pattern = '^.', -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
        before = '', -- "fg" or "bg" or empty
        keyword = 'wide', -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = 'fg', -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of highlight groups or use the hex color if hl not found as a fallback
    colors = {
        error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
        warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
        info = { 'DiagnosticInfo', '#2563EB' },
        hint = { 'DiagnosticHint', '#10B981' },
        default = { 'Identifier', '#7C3AED' },
        test = { 'Identifier', '#FF00FF' },
    },
    search = {
        command = 'rg',
        args = {
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
})

-- ######################## STANDARD KEYMAPS ##############################
local opts = { noremap = true }

local on_attach = function(client, bufnr)
    -- only allow null-ls to format
    if client.name ~= 'null-ls' then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
    require('illuminate').on_attach(client)

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Show [D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_workspace_symbols, 'Show [W]orkspace [S]ymbols')

    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, ' Hover documentation')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [r]eferences')
    nmap('gd', vim.lsp.buf.definition, ' [G]oto [d]efinition')
    nmap('gD', vim.lsp.buf.declaration, ' [G]oto [D]eclaration')
    nmap('gt', vim.lsp.buf.type_definition, ' [G]oto [t]ype definition')
    nmap('gi', vim.lsp.buf.implementation, ' [G]oto [i]mplementation')
    nmap('<c-h>', vim.lsp.buf.signature_help, ' Show signature [h]elp')
    nmap('<space>rn', vim.lsp.buf.rename, ' [r]e[n]ame')
    vim.keymap.set({ 'x' }, '<space>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ctions' })
    nmap('<space>fm', vim.lsp.buf.format, ' [f]or[m]at')
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
    'pylsp',
    'lua_ls',
    'tsserver',
    'clangd',
    'bashls',
    'ansiblels',
    'cmake',
    'cssls',
    'dockerls',
    'emmet_ls',
    'jdtls',
}

local status, mason = pcall(require, 'mason')
if not mason then
    return
end
local status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status then
    return
end
mason.setup({})
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local status, lspconfig = pcall(require, 'lspconfig')
if not status then
    return
end

-- see if a file exists
local function file_exists(file)
    local f = io.open(file, 'rb')
    if f then
        f:close()
    end
    return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
local function get_lines_from(file)
    if not file_exists(file) then
        return {}
    end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                completions = {
                    completeFunctionCalls = true,
                },
            },
        })
    end,
    ['lua_ls'] = function()
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })
    end,
    ['tsserver'] = function()
        lspconfig.tsserver.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' },
            settings = {
                completions = {
                    completeFunctionCalls = true,
                },
            },
        })
    end,
    ['solc'] = function()
        -- rely on proper configuration from remappings
        local remappings = get_lines_from('remappings.txt')
        local cmd = { 'solc', '--lsp', table.unpack(remappings) }
        lspconfig.solc.setup({
            cmd = cmd,
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        })
    end,
    ['pylsp'] = function()
        lspconfig.pylsp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                pylsp = {
                    -- see https://github.com/python-lsp/python-lsp-server#configuration
                    configurationSources = { 'flake8' },
                    plugins = {
                        flake8 = { enabled = true, ignore = { 'E501', 'E302', 'E303', 'W391', 'F401', 'E402' } },
                        -- jedi_completion = { enabled = true },
                        -- jedi_definition = { enabled = true },
                        -- jedi_hover = { enabled = true },
                        -- jedi_references = { enabled = true },
                        -- -- jedi_signature_help = { enabled = true },
                        -- jedi_symbols = { enabled = true, all_scopes = true },
                        mccabe = { enabled = false },
                        pycodestyle = { enabled = false },
                        pyflakes = { enabled = false },
                        -- yapf = { enabled = false },
                        -- mypy = { enabled = false },
                    },
                },
            },
        })
    end,
})

-- Setup nvim-cmp.
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
local status, lspkind = pcall(require, 'lspkind')
if not status then
    return
end
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
