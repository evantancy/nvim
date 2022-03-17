local function conf(name)
	return require(string.format("modules.config.%s", name))
end

local plugins = {
	{ -- Colorschemes
		"ellisonleao/gruvbox.nvim",
		config = conf("colors"),
	},
	{
		-- Startup screen
		"goolord/alpha-nvim",
		config = conf("alpha-nvim"),
	},
	{ -- Finder
		"nvim-telescope/telescope.nvim",
		-- config = conf("telescope"),
		requires = { "nvim-lua/plenary.nvim" },
	},
	{ -- File tree
		"kyazdani42/nvim-tree.lua",
		-- config = conf 'nvim-tree'
	},
	{ -- Icons
		"kyazdani42/nvim-web-devicons",
		-- config = conf 'nvim-web-devicons'
	},
	{ --Solidity
		"TovarishFin/vim-solidity",
	},
	{ -- Lsp
		"neovim/nvim-lspconfig",
		-- config = conf 'lsp',
		requires = {
			"williamboman/nvim-lsp-installer",
			"jose-elias-alvarez/null-ls.nvim",
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"RRethy/vim-illuminate",
		},
	},
	{ -- Autocompletion plugin
		"hrsh7th/nvim-cmp",
		-- config = conf 'nvim-cmp',
		requires = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{ -- Git related
		"lewis6991/gitsigns.nvim",
		-- config = conf 'gitsigns',
		requires = { "nvim-lua/plenary.nvim" },
	},

	{ -- Like magit
		"TimUntersberger/neogit",
		-- config = conf 'neogit',
		requires = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
	},
	{ -- Comments
		{ "tpope/vim-commentary" },
		{
			"tpope/vim-surround",
			requires = { "tpope/vim-repeat" },
		},
	},
	{ -- Autopairs
		"windwp/nvim-autopairs",
		-- config = conf 'nvim-autopairs'
	},
	{ -- Indent guides
		"lukas-reineke/indent-blankline.nvim",
		-- config = conf 'indent-blankline'
	},
	{ -- Bufferline
		"akinsho/nvim-bufferline.lua",
		-- config = conf 'nvim-bufferline'
	},
	{ -- Statusline
		"nvim-lualine/lualine.nvim",
		-- config = conf 'lualine'
	},
	{ -- Colorizer
		"norcalli/nvim-colorizer.lua",
		-- config = conf 'nvim-colorizer'
	},
}

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

local packer = safe_require("packer")
if packer then
	packer.init({
		compile_path = vim.fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
		package_root = vim.fn.stdpath("data") .. "/site/pack",
		display = {
			open_fn = function()
				return require("packer.util").float({
					border = "rounded",
				})
			end,
		},
	})

	return packer.startup(function(use)
		use("wbthomason/packer.nvim")
		for _, plugin in ipairs(plugins) do
			use(plugin)
		end
	end)
end
