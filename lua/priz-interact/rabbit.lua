local git_cache = {}

---@type string?
local dir = "/home/priz/Desktop/git/rabbit.nvim"
if vim.uv.fs_stat(tostring(dir)) == nil then
	dir = nil
end

return { ---@type LazyPluginSpec
	"voxelprismatic/rabbit.nvim",
	dir = dir,
	branch = "rewrite",
	lazy = false,
	cmd = "Rabbit",
	---@diagnostic disable-next-line: missing-fields
	opts = { ---@type Rabbit.Config
		keys = {
			switch = "<leader>r",
		},
	},
	config = function(self)
		require("rabbit").setup(self.opts)
		local select = require("rabbit.util.scripts").bind_select

		require("which-key").add({
			{ "<leader>t", name = "Rabbitscope" },
		})

		vim.keymap.set("n", "<leader>tg", select("forage", 1, { idx = 1, action = "rename" }), { desc = "rg" })
		vim.keymap.set("n", "<leader>tf", select("forage", 2, { idx = 1, action = "rename" }), { desc = "fzr" })
	end,
}
