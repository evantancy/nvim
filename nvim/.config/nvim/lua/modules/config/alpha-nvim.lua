return function()
    local alpha = safe_require('alpha')
    if not alpha then
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
    local main = '~/.config/nvim/init.lua'
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

    -- https://github.com/goolord/alpha-nvim/issues/14
    theme.opts.layout = {
        theme.section.header,
        { type = 'padding', val = 1 },
        theme.section.top_buttons,
        theme.section.mru,
        theme.section.mru_cwd,
        { type = 'padding', val = 1 },
        theme.section.footer,
    }

    alpha.setup(theme.config)
end
