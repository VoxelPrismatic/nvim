return { ---@type LazyPluginSpec
	"numToStr/Comment.nvim",
	lazy = true,
	config = true,
	keys = {
		{
			"<leader>/",
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			mode = { "n", "v", "x" },
			desc = "Comment line",
		},
		{
			"<leader>]",
			function()
				require("Comment.api").toggle.blockwise.current()
			end,
			mode = { "n", "v", "x" },
			desc = "Comment block",
		},
	},
	opts = {
		toggler = {
			line = "<leader>/",
			block = "<leader>]",
		},
		opleader = {
			line = "<leader>/",
			block = "<leader>]",
		},
	},
}
