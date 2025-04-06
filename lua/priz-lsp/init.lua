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
		"saghen/blink.cmp",
		version = "1.*",
		event = "InsertEnter",
		opts = { ---@type blink.cmp.Config
			sources = {
				default = { "lazydev", "lsp", "path", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			completion = {
				documentation = {
					auto_show = true,
				},
			},
			keymap = {
				preset = "none",
				["<S-Up>"] = { "select_prev", "fallback" },
				["<S-Down>"] = { "select_next", "fallback" },
				["<F1>"] = { "accept", "fallback" },
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
