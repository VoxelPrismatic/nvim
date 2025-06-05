function CopySplitBuffer(dir)
	local bufnr = vim.api.nvim_get_current_buf()

	local move = {
		left = "h",
		right = "l",
		up = "k",
		down = "j",

		j = "j",
		k = "k",
		h = "h",
		l = "l",
	}

	dir = move[dir]
	if dir == nil then
		vim.print("Invalid direction '" .. dir .. "'")
		return
	end

	local winnr = vim.fn.win_getid(vim.fn.winnr(dir))
	if winnr == 0 then
		vim.print("No window in direction '" .. dir .. "'")
		return
	end

	vim.api.nvim_set_current_win(winnr)
	vim.api.nvim_set_current_buf(bufnr)
end

local keymaps = {
	["<leader>s<Up>"] = {
		"Add split above",
		"<cmd>hor abo sp<CR>",
	},
	["<leader>s<Down>"] = {
		"Add split below",
		"<cmd>hor bel sp<CR>",
	},
	["<leader>s<Left>"] = {
		"Add split left",
		"<cmd>vert lefta sp<CR>",
	},
	["<leader>s<Right>"] = {
		"Add split right",
		"<cmd>vert rightb sp<CR>",
	},

	["<leader>k<Up>"] = {
		"Add term above",
		"<cmd>hor abo term<CR>i",
	},
	["<leader>k<Down>"] = {
		"Add term below",
		"<cmd>hor bel term<CR>i",
	},
	["<leader>k<Left>"] = {
		"Add term left",
		"<cmd>vert lefta term<CR>i",
	},
	["<leader>k<Right>"] = {
		"Add term right",
		"<cmd>vert rightb term<CR>i",
	},

	["<leader>S<right>"] = {
		"Copy buffer right",
		function()
			CopySplitBuffer("right")
		end,
	},

	["<leader>S<left>"] = {
		"Copy buffer left",
		function()
			CopySplitBuffer("left")
		end,
	},

	["<leader>S<up>"] = {
		"Copy buffer up",
		function()
			CopySplitBuffer("up")
		end,
	},

	["<leader>S<down>"] = {
		"Copy buffer down",
		function()
			CopySplitBuffer("down")
		end,
	},
}

for k, v in pairs(keymaps) do
	vim.keymap.set("n", k, v[2], {
		desc = v[1],
		noremap = true,
		silent = true,
	})
end

return {}
