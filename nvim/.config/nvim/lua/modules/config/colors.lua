vim.opt.termguicolors = true
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.tokyonight_style = 'night'
vim.o.background = 'dark'
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
