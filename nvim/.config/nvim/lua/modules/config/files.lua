local status, telescope = pcall(require, 'telescope')
if not status then
    return
end

local auto_session = safe_require('auto-session')
if auto_session then
    require('auto-session').setup({
        log_level = 'error',

        cwd_change_handling = {
            restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
            pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
            post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
                require('lualine').refresh() -- refresh lualine so the new session name is displayed in the status bar
            end,
        },
    })
end

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')
telescope.load_extension('media_files')

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
telescope.setup({
    defaults = {
        -- layout_config = {
        -- 	horizontal = {
        -- 		height = 0.9,
        -- 		preview_cutoff = 60,
        -- 		preview_width = 90,
        -- 		prompt_position = "bottom",
        -- 		width = 0.9,
        -- 	},
        -- },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--hidden',
            '--smart-case',
        },
        prompt_prefix = '> ',
        selection_caret = '>> ',
        color_devicons = true,
        path_display = {
            shorten = { len = 3, exclude = { 1, -1 } },
        },
        file_ignore_patterns = { 'node_modules/.*', '%.git/.*', '%.idea/.*', '%.vscode/.*' },
        -- sorting_strategy = "ascending",
        file_sorter = sorters.get_fzf_sorter,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-q>'] = actions.send_to_qflist,
                -- alt+p
                -- doesn't work atm
                -- ["<M-p>"] = action_layout.toggle_preview,
            },
            n = {
                ['<C-c>'] = actions.close,
                -- alt+p
                -- doesn't work atm
                -- ["<M-p>"] = action_layout.toggle_preview,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            -- the default case_mode is "smart_case"
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        },
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'pdf' },
            find_cmd = 'rg', -- find command (defaults to `fd`)
        },
    },
})

local status, nvim_tree = pcall(require, 'nvim-tree')
if not status then
    return
end
nvim_tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    filters = {
        -- whether to hide dotfiles
        dotfiles = false,
        -- Files to hide
        custom = { '.git', '.vscode' },
        -- exclude = { '.env*', '.*rc', '.config' },
    },
    renderer = {
        group_empty = false,
        indent_width = 2,
        highlight_git = true,
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = '└',
                edge = '│',
                item = '│',
                bottom = '─',
                none = ' ',
            },
        },
    },
    view = {
        width = 60,
        side = 'left',
        hide_root_folder = false,
        signcolumn = 'yes',
        mappings = {
            -- `custom_only = false` will merge list of mappings with defaults
            custom_only = true,
            list = {
                { key = 'R', action = 'refresh' },
                { key = 'a', action = 'create' },
                { key = 'd', action = 'remove' },
                { key = '<bs>', action = 'close_node' },
                { key = '<cr>', action = 'edit' },
                { key = '<space>r', action = 'rename' },
                { key = 'h', action = 'split' },
                { key = 'v', action = 'vsplit' },
                { key = 'x', action = 'cut' },
                { key = 'c', action = 'copy' },
                { key = 'p', action = 'paste' },
                { key = 'Y', action = 'copy_path' },
                { key = 'y', action = 'copy_name' },
                { key = 'I', action = 'toggle_ignored' },
                { key = 'G', action = 'toggle_git_ignored' },
                { key = 'H', action = 'toggle_dotfiles' },
                { key = 's', action = 'system_open' },
                { key = 'S', action = 'search_node' },
                { key = '-', action = 'dir_up' },
                { key = 'w', action = 'collapse_all' },
            },
        },
    },
})

local status, alpha = pcall(require, 'alpha')
if not status then
    return
end

local theme = require('alpha.themes.startify')

theme.section.header.val = {
    [[NEOVIM]] .. info(),
}

theme.section.top_buttons.val = {
    theme.button('e', 'New file', ':ene <BAR> startinsert <CR>'),
    theme.button('f', 'Find file', "<cmd>lua require('telescope.builtin').find_files()<cr>"),
    theme.button('q', 'Quit NVIM', ':qa<CR>'),
}
-- Shift buttons to only top_buttons
theme.section.bottom_buttons.val = {}
-- use as bookmarks
local main = '~/.config/nvim/init.vim'
local modules = '~/.config/nvim/lua/modules/init.lua'
local null_ls = '~/.config/nvim/lua/modules/config/null-ls.lua'
local lsp = '~/.config/nvim/lua/modules/config/lsp.lua'
theme.section.footer.val = {
    theme.button('i', main, ':e ' .. main .. '<cr>'),
    theme.button('m', modules, ':e ' .. modules .. '<cr>'),
    theme.button('n', null_ls, ':e ' .. null_ls .. '<cr>'),
    theme.button('l', lsp, ':e ' .. lsp .. '<cr>'),
}

theme.nvim_web_devicons.enabled = true
theme.nvim_web_devicons.highlight = true

-- theme.opts.layout = {
--     theme.section.header,
--     { type = 'padding', val = 1 },
--     theme.section.top_buttons,
--     theme.section.mru,
--     theme.section.mru_cwd,
--     { type = 'padding', val = 1 },
--     theme.section.footer,
-- }

alpha.setup(theme.config)
