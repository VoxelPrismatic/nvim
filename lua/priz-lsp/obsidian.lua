vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(evt)
		if vim.bo[evt.buf].filetype == "markdown" then
			vim.wo.conceallevel = 2
		else
			vim.wo.conceallevel = 0
		end
	end,
})

return { ---@type LazyPluginSpec
	"epwalsh/obsidian.nvim",
	lazy = true,
	ft = {
		"markdown",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "origin",
				path = "~/Documents/Obsidian/",
			},
		},
	},
	cmd = {
		"Obsidian",
	},
}
