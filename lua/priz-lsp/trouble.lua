return {
	"folke/trouble.nvim",
	lazy = false,
	opts = { ---@type trouble.Config
		modes = {
			diagnostics = {
				auto_close = true,
				open_no_results = true,
				warn_no_results = true,
			},
		},
		filter = {
			["not"] = {
				{
					severity = vim.diagnostic.severity.HINT,
				},
			},
		},
		win = { ---@type trouble.Window.split
			type = "split",
			relative = "editor",
			size = 96,
			position = "right",
		},
	},
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>xcs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>xcl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}
