local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimports()
		for _, client in pairs(vim.lsp.get_clients()) do
			if client.name == "templ" then
				vim.cmd("silent! LspRefresh templ")
				return
			end
		end
	end,
	group = format_sync_grp,
})

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

return {
	enabled = false,
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			diagnostic = {
				virtual_text = {
					current_line = false,
				},
			},
		})
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
		})
	end,
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
