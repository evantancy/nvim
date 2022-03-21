local function conf(name)
	return require(string.format("modules.config.%s", name))
end

local plugins = {
	{ -- Colorschemes
		"ellisonleao/gruvbox.nvim",
		config = conf("colors"),
	},
	{ -- Startup screen
		"goolord/alpha-nvim",
		config = conf("alpha-nvim"),
	},
	{ -- Finder
		"nvim-telescope/telescope.nvim",
		config = conf("telescope"),
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	},
	{ -- whichkey
		"folke/which-key.nvim",
	},
	{ -- Icons
		"kyazdani42/nvim-web-devicons",
	},
	{ -- Solidity
		"TovarishFin/vim-solidity",
	},
	{ -- Formatters
		"jose-elias-alvarez/null-ls.nvim",
		config = conf("null-ls"),
	},
	{ -- Autocompletion plugin
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
		},
	},
	{ -- AI Autocompletion
		"tzachar/cmp-tabnine",
		-- config = conf("tabnine"),
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
	},
	{ -- Lsp
		"neovim/nvim-lspconfig",
		config = conf("lsp"),
		requires = {
			"williamboman/nvim-lsp-installer",
			"jose-elias-alvarez/null-ls.nvim",
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			"RRethy/vim-illuminate",
		},
	},
	{ -- Git related
		"lewis6991/gitsigns.nvim",
		config = conf("gitsigns"),
		requires = { "nvim-lua/plenary.nvim" },
	},
	{ -- Surround comments/tags/brackets
		"tpope/vim-surround",
		requires = { "tpope/vim-repeat" },
	},
	{ -- Auto complete functions etc
		"tpope/vim-endwise",
	},
	{ -- Comments
		"numToStr/Comment.nvim",
		config = conf("comment"),
	},
	{ -- File tree
		"kyazdani42/nvim-tree.lua",
		config = conf("nvim-tree"),
	},
	{ -- Highlighter
		"nvim-treesitter/nvim-treesitter",
		config = conf("nvim-treesitter"),
	},
	{ -- Highlighter
		"windwp/nvim-ts-autotag",
		config = conf("nvim-ts-autotag"),
	},
	{ -- Autopairs
		"windwp/nvim-autopairs",
		config = conf("nvim-autopairs"),
	},
	{ -- Indent guides
		"lukas-reineke/indent-blankline.nvim",
		config = conf("indent-blankline"),
	},
	{ -- Bufferline
		"akinsho/nvim-bufferline.lua",
		config = conf("bufferline"),
	},
	{ -- Statusline
		"nvim-lualine/lualine.nvim",
		config = conf("lualine"),
	},
	{ -- Terminal
		"akinsho/toggleterm.nvim",
		config = conf("toggleterm"),
	},
}

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd("packadd packer.nvim")
end

local packer = safe_require("packer")
if packer then
	packer.init({
		compile_path = vim.fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
		package_root = vim.fn.stdpath("data") .. "/site/pack",
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
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
