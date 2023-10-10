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

local status, copilot = pcall(require, 'copilot')
if status then
    copilot.setup({
        suggestion = { enabled = true },
        panel = { enabled = true },
        filetypes = {
            ['*'] = true,
            gitcommit = false,
            NeogitCommitMessage = false,
            NvimTree = false,
            python = true,
            javascript = true,
            javascriptreact = true,
        },
        auto_refresh = true,
    })
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

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
})

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
    nmap('<space>fm', vim.lsp.buf.format, '[f]or[m]at')
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

-- 'pylsp',
local servers = {
    'pyright',
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
    ['pyright'] = function()
        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            -- Note: the single_file_support option is not from the language server, but from Neovim itself and controls whether or not to start the language server if it can’t detect the working directory as a project.
            single_file_support = true,
            settings = {
                pyright = {
                    disableLanguageServices = false,
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        autoImportCompletions = true,
                        autoSearchPaths = true,
                        diagnosticMode = 'workspace', -- openFilesOnly, workspace
                        typeCheckingMode = 'basic', -- off, basic, strict
                        useLibraryCodeForTypes = true,
                    },
                },
            },
        })
    end,
    ['pylsp'] = function()
        lspconfig.pylsp.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            -- Note: the single_file_support option is not from the language server, but from Neovim itself and controls whether or not to start the language server if it can’t detect the working directory as a project.
            single_file_support = true,
            settings = {
                pylsp = {
                    -- see https://github.com/python-lsp/python-lsp-server#configuration
                    configurationSources = { '' },
                    plugins = {
                        flake8 = { enabled = false, ignore = { 'E501', 'E302', 'E303', 'W391', 'F401', 'E402', 'E265' } },
                        jedi_completion = { enabled = false },
                        jedi_definition = { enabled = false },
                        jedi_hover = { enabled = false },
                        jedi_references = { enabled = false },
                        jedi_signature_help = { enabled = false },
                        jedi_symbols = { enabled = false, all_scopes = false, include_import_symbols = false },
                        preload = { enabled = false, modules = { 'numpy', 'scipy' } },
                        mccabe = { enabled = false },
                        mypy = { enabled = false },
                        isort = { enabled = false },
                        spyder = { enabled = false },
                        memestra = { enabled = false },
                        pycodestyle = { enabled = false }, -- not work
                        pyflakes = { enabled = false },
                        yapf = { enabled = false },
                        pylint = {
                            enabled = false,
                        },
                        rope = { enabled = true },
                        rope_completion = { enabled = false, eager = false },
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
    copilot = '[Copilot]',
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
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' }, -- only for Lua
        -- { name = 'cmp_tabnine' },
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
        -- ghost_text = true,
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

cfg = {
    debug = false, -- set to true to enable debug logging
    log_path = vim.fn.stdpath('cache') .. '/lsp_signature.log', -- log dir when debug is on
    -- default is  ~/.cache/nvim/lsp_signature.log
    verbose = false, -- show debug line number

    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    max_height = 12, -- max height of signature floating_window
    max_width = 80, -- max_width of signature floating_window
    noice = false, -- set to true if you using noice to render markdown
    wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap

    floating_window_off_x = 1, -- adjust float windows x position.
    -- can be either a number or function
    floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
    -- can be either number or function, see examples
    close_timeout = 4000, -- close floating window after ms when laster parameter is entered
    fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = '🐼 ', -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
    hint_scheme = 'String',
    hint_inline = function()
        return false
    end, -- should the hint be inline(nvim 0.10 only)?  default false
    hi_parameter = 'LspSignatureActiveParameter', -- how your parameter will be highlight
    handler_opts = {
        border = 'rounded', -- double, rounded, single, shadow, none, or a table of borders
    },
    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
    padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    toggle_key_flip_floatwin_setting = false, -- true: toggle float setting after toggle key pressed
    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}

-- recommended:
require('lsp_signature').setup(cfg) -- no need to specify bufnr if you don't use toggle_key
-- You can also do this inside lsp on_attach
require('lsp_signature').on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
-- Call the setup function to change the default behavior
require('symbols-outline').setup({
    highlight_hovered_item = false, -- disable due to high cpu usage
    show_guides = true,
    auto_preview = false,
    position = 'right',
    relative_width = true,
    width = 25,
    auto_close = false,
    show_numbers = true,
    show_relative_numbers = true,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    autofold_depth = nil,
    auto_unfold_hover = true,
    fold_markers = { '', '' },
    wrap = false,
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { '<Esc>', 'q' },
        goto_location = '<Cr>',
        focus_location = 'o',
        hover_symbol = '<C-space>',
        toggle_preview = 'K',
        rename_symbol = 'r',
        code_actions = 'a',
        fold = 'h',
        unfold = 'l',
        fold_all = 'W',
        unfold_all = 'E',
        fold_reset = 'R',
    },
    lsp_blacklist = { 'pylsp' },
    symbol_blacklist = {},
    symbols = {
        File = { icon = '', hl = '@text.uri' },
        Module = { icon = '', hl = '@namespace' },
        Namespace = { icon = '', hl = '@namespace' },
        Package = { icon = '', hl = '@namespace' },
        Class = { icon = '𝓒', hl = '@type' },
        Method = { icon = 'ƒ', hl = '@method' },
        Property = { icon = '', hl = '@method' },
        Field = { icon = '', hl = '@field' },
        Constructor = { icon = '', hl = '@constructor' },
        Enum = { icon = 'ℰ', hl = '@type' },
        Interface = { icon = 'ﰮ', hl = '@type' },
        Function = { icon = '', hl = '@function' },
        Variable = { icon = '', hl = '@constant' },
        Constant = { icon = '', hl = '@constant' },
        String = { icon = '𝓐', hl = '@string' },
        Number = { icon = '#', hl = '@number' },
        Boolean = { icon = '⊨', hl = '@boolean' },
        Array = { icon = '', hl = '@constant' },
        Object = { icon = '⦿', hl = '@type' },
        Key = { icon = '🔐', hl = '@type' },
        Null = { icon = 'NULL', hl = '@type' },
        EnumMember = { icon = '', hl = '@field' },
        Struct = { icon = '𝓢', hl = '@type' },
        Event = { icon = '🗲', hl = '@type' },
        Operator = { icon = '+', hl = '@operator' },
        TypeParameter = { icon = '𝙏', hl = '@parameter' },
        Component = { icon = '', hl = '@function' },
        Fragment = { icon = '', hl = '@constant' },
    },
})

local status, trouble = pcall(require, 'trouble')
if status then
    trouble.setup({
        position = 'bottom', -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = 'workspace_diagnostics', -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
        fold_open = '', -- icon used for open folds
        fold_closed = '', -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        cycle_results = false, -- cycle item list when reaching beginning or end of list
        action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = 'q', -- close the list
            cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
            refresh = 'r', -- manually refresh
            jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
            open_split = { '<c-x>' }, -- open buffer in new split
            open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
            open_tab = { '<c-t>' }, -- open buffer in new tab
            jump_close = { 'o' }, -- jump to the diagnostic and close the list
            toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
            switch_severity = 's', -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
            toggle_preview = 'P', -- toggle auto_preview
            hover = 'K', -- opens a small popup with the full multiline message
            preview = 'p', -- preview the diagnostic location
            close_folds = { 'zM', 'zm' }, -- close all folds
            open_folds = { 'zR', 'zr' }, -- open all folds
            toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
            previous = 'k', -- previous item
            next = 'j', -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { 'lsp_definitions' }, -- for the given modes, automatically jump if there is only a single result
        signs = {
            -- icons / text used for a diagnostic
            error = '',
            warning = '',
            hint = '',
            information = '',
            other = '',
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    })
end
