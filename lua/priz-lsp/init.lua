vim.debug = {
	nvim_win_get_all_options = function(winid)
		---@type table<string, vim.api.keyset.get_option_info>
		local all_options = vim.api.nvim_get_all_options_info()
		local opts = vim.wo[winid]
		local ret = {}
		for k, v in pairs(all_options) do
			if v.scope ~= "win" then
				goto continue
			end
			ret[k] = opts[k]
			::continue::
		end

		return ret
	end,
	nvim_buf_get_all_options = function(bufid)
		---@type table<string, vim.api.keyset.get_option_info>
		local all_options = vim.api.nvim_get_all_options_info()
		local opts = vim.bo[bufid]
		local ret = {}
		for k, v in pairs(all_options) do
			if v.scope ~= "buf" then
				goto continue
			end
			ret[k] = opts[k]
			::continue::
		end

		return ret
	end,
}
return { ---@type LazyPluginSpec[]
	{
		"neovim/nvim-lspconfig",
		lazy = true,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},

		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(_) end,
				},
				mapping = {
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<F4>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<F3>"] = cmp.mapping.close(),
					["<F2>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<F1>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},
	{
		"folke/neodev.nvim",
		lazy = false,
		config = true,
		priority = 500,
	},
}
