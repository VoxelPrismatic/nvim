return {
	"m4xshen/hardtime.nvim",
	enabled = false,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim"
	},
	opts = {
		disable_mouse = false,
		restricted_keys = {
			["<Up>"] = { "", "i" },
			["<Down>"] = { "", "i" },
			["<Left>"] = { "", "i" },
			["<Right>"] = { "", "i" },
		},
		disabled_keys = {
			["<Up>"] = { },
			["<Down>"] = { },
			["<Left>"] = { },
			["<Right>"] = { },
		},
		disabled_filetypes = {
			"qf",
			"netrw",
			"NvimTree",
			"lazy",
			"mason",
			"oil"
		},
	}
}
