local function conf(name)
    return require(string.format('modules.config.%s', name))
end

local plugins = {
    { 'rebelot/kanagawa.nvim' },
    { 'ellisonleao/gruvbox.nvim' },
    { 'haishanh/night-owl.vim' },
    { -- Colorschemes
        'folke/tokyonight.nvim',
        requires = { 'folke/lsp-colors.nvim' },
        config = conf('colors'),
    },
    { -- LSP colors
        'folke/lsp-colors.nvim',
    },
    { -- Icons
        'ryanoasis/vim-devicons',
        'kyazdani42/nvim-web-devicons',
    },
    { -- File tree
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        config = conf('nvim-tree'),
    },
    { -- Startup screen
        'goolord/alpha-nvim',
        config = conf('alpha-nvim'),
    },
    { -- Jump around quickly
        'easymotion/vim-easymotion',
    },
    { -- whichkey
        'folke/which-key.nvim',
    },
    { -- Finder
        'nvim-telescope/telescope.nvim',
        config = conf('telescope'),
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-telescope/telescope-media-files.nvim' },
        },
    },
    { -- Solidity
        'TovarishFin/vim-solidity',
    },
    { -- LSP
        'neovim/nvim-lspconfig',
        config = conf('lsp'),
        requires = {
            'williamboman/nvim-lsp-installer',
            'jose-elias-alvarez/null-ls.nvim',
            { 'jose-elias-alvarez/nvim-lsp-ts-utils', branch = 'main' },
            'RRethy/vim-illuminate',
        },
    },
    { -- Formatters
        'jose-elias-alvarez/null-ls.nvim',
        branch = 'main',
        config = conf('null-ls'),
    },
    { -- Autocompletion plugin
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind-nvim',
        },
    },
    { -- AI Autocompletion
        'tzachar/cmp-tabnine',
        config = conf('tabnine'),
        run = './install.sh',
        requires = 'hrsh7th/nvim-cmp',
    },
    -- { -- Copilot
    -- 	"github/copilot.vim",
    -- config = conf("copilot")
    -- },
    { -- Autocomplete comments/tags/brackets
        'tpope/vim-surround',
        requires = { 'tpope/vim-repeat' },
    },
    { -- Autocomplete functions
        'tpope/vim-endwise',
    },
    { -- Autocomplete HTML tags
        'windwp/nvim-ts-autotag',
        config = conf('nvim-ts-autotag'),
    },
    { -- Autocomplete bracket pairs
        'windwp/nvim-autopairs',
        config = conf('nvim-autopairs'),
    },
    { -- Auto indent blanklines
        'lukas-reineke/indent-blankline.nvim',
        config = conf('indent-blankline'),
    },
    { -- I love you tpope <3
        'tpope/vim-fugitive',
    },
    { -- Diff files
        'sindrets/diffview.nvim',
        -- config = conf("diffview"),
        requires = 'nvim-lua/plenary.nvim',
    },
    { -- Git in signcolumn
        'lewis6991/gitsigns.nvim',
        config = conf('gitsigns'),
        requires = { 'nvim-lua/plenary.nvim' },
    },
    { -- Comments
        'numToStr/Comment.nvim',
        config = conf('comment'),
    },
    { -- Highlighter
        'nvim-treesitter/nvim-treesitter',
        config = conf('nvim-treesitter'),
    },
    { -- Bufferline
        'akinsho/nvim-bufferline.lua',
        config = conf('bufferline'),
    },
    { -- Statusline
        'nvim-lualine/lualine.nvim',
        config = conf('lualine'),
    },
    { -- Speed
        'ThePrimeagen/harpoon',
        requires = { 'nvim-lua/plenary.nvim' },
    },
    { -- Markdown
        'iamcco/markdown-preview.nvim',
        run = 'cd app && yarn install',
        config = conf('markdown-preview'),
    },
    { -- Visualize undo trees
        'mbbill/undotree',
    },
    { -- Display hex color codes
        'RRethy/vim-hexokinase',
        run = 'make hexokinase',
        config = conf('hexokinase'),
    },
}

for _, plugin in ipairs(plugins) do
    if plugin['config'] == nil then
        return
    else
        use(plugin['config'])
    end
end

-- Packer config

-- local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--     vim.fn.system({
--         'git',
--         'clone',
--         '--depth',
--         '1',
--         'https://github.com/wbthomason/packer.nvim',
--         install_path,
--     })
--     vim.cmd('packadd packer.nvim')
-- end

-- local packer = require('packer')
-- if packer then
--     packer.init({
--         compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
--         package_root = vim.fn.stdpath('data') .. '/site/pack',
--         display = {
--             open_fn = function()
--                 return require('packer.util').float({ border = 'rounded' })
--             end,
--         },
--     })

--     return packer.startup(function(use)
--         use('wbthomason/packer.nvim')
--         for _, plugin in ipairs(plugins) do
--             TODO: wrap plugin inside function
--             use(plugin)
--         end
--     end)
-- end
