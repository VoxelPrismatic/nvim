return { ---@type LazyPluginSpec
	"abzcoding/lsp_lines.nvim",
	event = "LspAttach",
	init = function()
		require("lsp_lines").setup()
		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = true,
		})
	end,
}
