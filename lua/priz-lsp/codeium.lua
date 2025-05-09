return { ---@type LazyPluginSpec
	"Exafunction/windsurf.nvim",
	name = "codeium.nvim",
	enabled = false,
	disabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = "InsertEnter",
	config = true,
	opts = {
		enable_chat = true,
		quiet = true,
		enable_cmp_source = false,
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
