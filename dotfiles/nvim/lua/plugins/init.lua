return {

	{
    	"stevearc/conform.nvim",
		event = 'BufWritePre', -- uncomment for format on save
		opts = require "configs.conform",
	},

	{
		"sindrets/diffview.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("diffview").setup({})
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip.loaders.from_lua").lazy_load({
				paths = "~/.var/app/io.neovim.nvim/config/nvim/lua/custom/snippets"
			})
		end,
		lazy = false,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require "configs.lspconfig"
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim", "lua", "vimdoc",
				"html", "css", "c", "python", "cpp"
			},
		},
	},


	{
		"Diogo-ss/42-header.nvim",
		cmd = { "Stdheader" },
		keys = { "<F1>" },
		opts = {
			default_map = true, -- Default mapping <F1> in normal mode.
			auto_update = true, -- Update header when saving.
			user = "marcsilv", -- Your user.
			mail = "marcsilv@42.student.fr", -- Your mail.
		},
		config = function(_, opts)
			require("42header").setup(opts)
		end,
	},

	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	{
		"mg979/vim-visual-multi",
		branch = "master", -- explicitly specify branch
		init = function()
    -- Optional: Set your custom key mappings or settings here
		vim.g.VM_default_mappings = 0
		vim.g.VM_maps = {
			["Find Under"]         = "<C-d>",
			["Find Subword Under"] = "<C-d>",
			["Select All"]         = "<C-S-d>",
			["Add Cursor Down"]    = "<C-j>",
			["Add Cursor Up"]      = "<C-k>",
		}
		vim.VM_show_warnings = 0
		end,
		lazy = false,
	},-- Load it immediately or adjust as you prefer
}
