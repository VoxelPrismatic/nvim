_COL_OFFSET = {}

local function realcolumn()
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")

	return vim.fn.strdisplaywidth(vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1]:sub(1, col - 1))
end

function _TABSTOP()
	local c = realcolumn()
	_COL_OFFSET[vim.fn.win_getid(vim.fn.winnr())] = c
	return c
end

vim.keymap.set("n", "<leader>T", _TABSTOP, {
	noremap = true,
	silent = false,
	desc = "Set tabstop",
})

local icons = {
	indicators = {
		error = "",
		warn = "󰔶",
		warning = "󰔶",
		info = "",
		hint = "󱐋",
	},

	modifiers = {
		modified = "󱐋",
		readonly = "",
		unnamed = "",
		newfile = "",
	},
}

icons.mod_arr = {
	icons.modifiers.modified,
	icons.modifiers.readonly,
	icons.modifiers.newfile,
}

local function lua_filename(fn, _)
	local mod = ""
	for _, v in ipairs(icons.mod_arr) do
		if fn:sub(-#v) == v then
			mod = fn:sub(-(#v + 1))
			fn = fn:sub(1, -(#v + 2))
			break
		end
	end

	if fn == "[No Name]" then
		fn = ""
	end

	if fn:len() > 0 then
		return fn .. mod
	elseif vim.bo.filetype:len() > 0 then
		return vim.bo.filetype .. mod
	end
	return "#nil" .. mod
end

local line_seps = {
	left = "",
	right = "",
	circle = "",
	line = "",
}

local other_icons = {
	vim = "",
	bot = "󰮯",
	line = "",
	sleep = "󰤄",
	term = "",
	cur = "󰇀",
	zap = "󱐋",
	more = "",
	copilot = "",
	copilot_nil = "",
}

local timer_ani = {
	"󰋙",
	"󰫃",
	"󰫄",
	"󰫅",
	"󰫆",
	"󰫇",
	"󰫈",
}

-- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/utils/mode.lua
local mode_msgs = {
	["n"] = other_icons.vim .. " NORMAL", -- Normal
	["no"] = other_icons.vim .. " OPERATOR", -- Normal, but the operator is waiting for a quantity
	["nov"] = other_icons.vim .. " v/OPERATOR", -- Visual, but the operator is waiting for a quantity
	["noV"] = other_icons.vim .. " v/OPERATOR", -- V-line, but the operator is waiting for a quantity
	["no\22"] = other_icons.vim .. " v/OPERATOR", -- V-block, but the operator is waiting for a quantity

	["v"] = other_icons.vim .. " VISUAL", -- Visual
	["V"] = other_icons.vim .. " V-LINE", -- V-line
	["\22"] = other_icons.vim .. " V-BLOCK", -- V-block

	["s"] = other_icons.cur .. " SELECT", -- Select
	["S"] = other_icons.cur .. " S-LINE", -- S-Line
	["\19"] = other_icons.cur .. " S-BLOCK", -- S-Block

	["i"] = other_icons.vim .. " INSERT", -- Insert

	["R"] = other_icons.zap .. " REPLACE", -- Replace

	["rm"] = other_icons.more .. " MORE", -- More-prompt
	["r?"] = other_icons.more .. " CONFIRM", -- Confirm-prompt

	["c"] = other_icons.vim .. " COMMAND", -- Command

	["!"] = other_icons.term .. " SHELL", -- Shell
	["t"] = other_icons.term .. " TERMINAL", -- Terminal

	["_"] = other_icons.sleep .. " INACTIVE", -- Inactive window
}

local function spread(template)
	local result = {}
	for key, value in pairs(template) do
		result[key] = value
	end

	return function(table)
		for key, value in pairs(table) do
			result[key] = value
		end
		return result
	end
end

return {
	{
		"akinsho/bufferline.nvim",
		event = "UIEnter",
		config = function()
			require("bufferline").setup({
				options = {
					right_mouse_command = nil,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, _, _)
						return icons.indicators[level] .. count
					end,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		name = "lualine",
		event = "UIEnter",
		config = function()
			local rose_pine = require("rose-pine.palette")
			require("nvim-web-devicons").setup({
				override = {
					__blank = {
						icon = " ",
						name = "Blank",
					},
				},
				color_icons = false,
			})

			local components = {
				lualine_a = {
					{
						"mode",
						icons_enabled = false,
						fmt = function(n)
							return mode_msgs[vim.fn.mode()] or other_icons.vim .. " " .. vim.fn.mode() .. " := " .. n
						end,
					},
				},

				lualine_y = {
					{
						function()
							local clients = vim.lsp.get_clients()
							local selected = "nil"
							local seconds = math.floor(vim.loop.gettimeofday() / 5)
							if #clients > 0 then
								selected = clients[math.fmod(seconds, #clients) + 1].name
							end

							return other_icons.bot .. #clients .. " " .. selected
						end,
					},
					pcall(require, "codeium.virtual_text") == true and {
						function()
							if vim.fn.mode() ~= "i" then
								return ""
							end
							local codeium = require("codeium.virtual_text").status_string():gsub("%s+", "")
							if codeium == "*" then
								local ms = math.floor(vim.loop.hrtime() / 1000 / 1000 / 100)
								return timer_ani[math.fmod(ms, #timer_ani) + 1]
							elseif codeium == "0" then
								return other_icons.copilot_nil
							end
							return other_icons.copilot .. " " .. codeium
						end,
					} or nil,
				},

				lualine_b = {
					{ "branch" },
					{
						"diff",
						diff_color = {
							added = { fg = rose_pine.iris },
							modified = { fg = rose_pine.gold },
							removed = { fg = rose_pine.rose },
						},
						symbols = { removed = "–" },
					},
				},

				lualine_c = {
					{
						"filetype",
						icons_enabled = true,
						icon_only = true,
						colored = false,
						icon = { align = "left" },
						separator = "",
						padding = { left = 1, right = 0 },
						draw_empty = true,
						fmt = function(c, ctx)
							-- Add a space when no filetype is found
							ctx.options.separator = (#c == 0) and " " or ""
							return c
						end,
					},
					{
						"filename",
						separator = "",
						padding = { left = 0, right = 1 },
						symbols = icons.modifiers,
						fmt = lua_filename,
					},
				},

				lualine_x = {
					{
						"diagnostics",
						sources = { "nvim_lsp" },
						sections = { "error", "warn", "info", "hint" },
						color_error = rose_pine.love,
						color_warn = rose_pine.gold,
						color_info = rose_pine.iris,
						color_hint = rose_pine.muted,
						symbols = icons.indicators,
					},
				},

				lualine_z = {
					{
						"%l/%L",
						icons_enabled = true,
						icon = other_icons.line,
						color = { gui = "bold" },
						padding = { left = 1, right = 0 },
					},
					{
						function()
							-- Real column, including tabs and extended characters
							local offset = (_COL_OFFSET[vim.fn.win_getid(vim.fn.winnr())] or 0)
							local ret = realcolumn()

							if offset > 0 then
								return (ret - offset) .. "+" .. offset
							end

							return ret
						end,
						color = { gui = "italic" },
						padding = { left = 0, right = 0 },
					},
					{
						-- Virtual column; counting bytes
						"%c",
						color = { gui = "italic", fg = rose_pine.highlight_high },
						padding = { left = 0, right = 1 },
					},
				},
			}

			require("lualine").setup({
				options = {
					theme = "rose-pine-neutral",
					section_separators = { left = line_seps.left, right = line_seps.right },
					component_separators = { left = line_seps.line, right = line_seps.line },
					icons_enabled = true,
				},

				inactive_sections = spread(components)({
					lualine_a = {
						{
							"mode",
							fmt = function(_)
								return mode_msgs["_"]
							end,
							icons_enabled = false,
							icon = other_icons.vim,
						},
					},
				}),

				sections = components,
			})
		end,
	},
}
