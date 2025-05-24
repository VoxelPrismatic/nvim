return { ---@type LazyPluginSpec[]
	{
		"kevinhwang91/nvim-ufo",
		event = "LspAttach",
		main = "ufo",
		config = true,
		dependencies = {
			"kevinhwang91/promise-async",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,
		},
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				mode = "n",
				desc = "Open all folds",
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				mode = "n",
				desc = "Close all folds",
			},
			{
				"zq",
				"za",
				mode = "n",
				desc = "Toggle fold",
			},
		},
		init = function()
			vim.o.foldcolumn = "0" -- No fold column; difficult to make out relative line numbers
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.foldenable = true
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = "LspAttach",
		build = ":TSUpdate",
		lazy = false,
		branch = "main",
		config = true,
		opts = { ---@type TSConfig
			auto_install = true,
			sync_install = false,
			ensure_installed = {
				"markdown",
				"markdown_inline",
			},
			indent = {
				enable = true,
			},
			ignore_install = {},
			modules = {},
		},
	},
}
