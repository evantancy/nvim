vim.g.gruvbox_contrast_dark = 'hard'
vim.g.tokyonight_style = 'night'
if not vim.g.vscode then
    vim.cmd([[
        " This line enables the true color support.
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        " set t_Co=256
        " colorscheme gruvbox
        " colorscheme kanagawa
        " colorscheme onedark
        colorscheme monokai-pro
        " colorscheme night-owl
        ]])
end
-- set underline due to colorscheme doing some funny stuff
vim.api.nvim_set_hl(0, 'CursorLine', { underline = true })
vim.cmd([[
:hi Search    gui=NONE guifg=black guibg=yellow
:hi IncSearch    gui=NONE guifg=black guibg=yellow
]])

local status, illuminate = pcall(require, 'illuminate')
if not status then
    return
end
-- default configuration
illuminate.configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    -- See `:help mode()` for possible values
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    -- See `:help mode()` for possible values
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = nil,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
})

local status, bufferline = pcall(require, 'bufferline')
if not status then
    return
end

bufferline.setup({
    options = {
        mode = 'buffers',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is deduplicated
        tab_size = 15,
        diagnostics = 'nvim_lsp',
        offsets = { { filetype = 'NvimTree' } },
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = 'thick',
        always_show_bufferline = true,
        modified_icon = '[+]',
    },
})
