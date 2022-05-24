local telescope = safe_require('telescope')
if not telescope then
    return
end

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
            shorten = { len = 2, exclude = { 1, -1 } },
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
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')
telescope.load_extension('media_files')
