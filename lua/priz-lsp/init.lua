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
					auto_show_delay_ms = 150,
					window = {
						border = "padded",
					},
				},
				ghost_text = {
					enabled = false,
					show_with_menu = false,
				},
				trigger = {
					show_on_keyword = true,
					show_on_trigger_character = true,
					show_on_insert_on_trigger_character = true,
					show_on_x_blocked_trigger_characters = {
						"'",
						'"',
					},
					show_on_blocked_trigger_characters = {
						"\n",
						"\t",
					},
				},
				menu = {
					draw = {
						columns = {
							{ "kind_icon", gap = 1 },
							{ "label", "label_description", gap = 1 },
						},
						components = {
							kind_icon = {
								highlight = function(ctx)
									return ctx.kind_hl
								end,
							},
						},
					},
				},
			},
			keymap = {
				preset = "none",
				["<S-Up>"] = { "show", "select_prev", "fallback" },
				["<S-Down>"] = { "show", "select_next", "fallback" },
				["<F1>"] = { "show", "cancel", "fallback" },
				["<Tab>"] = { "select_and_accept", "fallback" },
				["<F2>"] = { "show", "hide", "fallback" },
			},
		},
		config = function(config)
			require("blink.cmp").setup(config.opts)
			local palette = require("rose-pine.palette")
			require("rabbit.term.highlight").apply({
				BlinkCmpLabelDeprecated = {
					force = true,
					fg = palette.love,
					strikethrough = true,
				},
				BlinkCmpKindMethod = {
					force = true,
					fg = palette.love,
					bold = true,
				},
				BlinkCmpKindFunction = {
					force = true,
					link = "BlinkCmpKindMethod",
				},
				BlinkCmpConstructor = {
					force = true,
					fg = palette.iris,
					bold = true,
				},
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		config = true,
		opts = { ---@type lazydev.Config
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				"LazyVim",
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		event = "LspAttach",
		config = function()
			local dap = require("dap")
			require("which-key").add({
				{ "<leader>d", name = "Debug" },
			})

			---@param func fun(opts: any)
			---@return fun()
			local function bind(func)
				return function()
					func()
				end
			end

			vim.keymap.set("n", "<leader>dB", bind(dap.clear_breakpoints), { desc = "Clear bps" })
			vim.keymap.set("n", "<leader>db", bind(dap.toggle_breakpoint), { desc = "Breakpoint" })
			vim.keymap.set("n", "<leader>dc", bind(dap.continue), { desc = "Continue" })
			vim.keymap.set("n", "<leader>dt", bind(dap.terminate), { desc = "Terminate" })
			vim.keymap.set("n", "<leader>ds", bind(dap.step_over), { desc = "Step next" })
			vim.keymap.set("n", "<leader>dS", bind(dap.step_into), { desc = "Step back" })
		end,
	},
}
