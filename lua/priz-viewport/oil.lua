---@diagnostic disable-next-line: undefined-global
local vim = vim

function PrizCloseOil()
	if vim.bo[0].filetype == "oil" then
		require("oil").discard_all_changes()
		require("oil").close()
	end
end

function PrizkeymapToggleOil()
	if vim.bo[0].filetype == "oil" then
		require("oil").discard_all_changes()
		require("oil").close()
	else
		vim.cmd("Oil")
	end
end

return { ---@type LazyPluginSpec
	"stevearc/oil.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = true,
	cmd = "Oil",
	opts = {
		skip_confirm_for_simple_edits = true,
		watch_for_changes = true,
		float = {
			padding = 8,
		},
	},
	keys = {
		{
			"<leader>n",
			PrizkeymapToggleOil,
			desc = "Oil",
		},
	},
}
