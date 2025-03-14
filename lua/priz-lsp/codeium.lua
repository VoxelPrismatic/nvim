return { ---@type LazyPluginSpec
	"Exafunction/codeium.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = true,
	opts = {
		enable_chat = true,
		virtual_text = {
			enabled = true,
			idle_delay = 50,
			key_bindings = {
				accept = "<Tab>",
				accept_line = "<F10>",
			},
		},
	},
}
