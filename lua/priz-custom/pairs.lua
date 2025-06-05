---@param lhs string ( [ < "
---@param rhs string ) ] > "
local function wrap_pairs(lhs, rhs)
	vim.fn.feedkeys("")
	vim.defer_fn(function()
		local start = { line = vim.fn.line("'<"), col = vim.fn.col("'<") }
		local fin = { line = vim.fn.line("'>"), col = vim.fn.col("'>") }
		if start.line == fin.line then
			local this_line = vim.api.nvim_buf_get_lines(0, start.line - 1, start.line, false)[1]
			local new_line = this_line:sub(1, start.col - 1)
				.. lhs
				.. this_line:sub(start.col, fin.col)
				.. rhs
				.. this_line:sub(fin.col + 1)

			vim.api.nvim_buf_set_lines(0, start.line - 1, start.line, false, { new_line })
			vim.fn.setpos("'<", { 0, start.line, start.col + 1 })
			vim.fn.setpos("'>", { 0, fin.line, fin.col + 1 })
		else
			local start_line = vim.api.nvim_buf_get_lines(0, start.line - 1, start.line, false)[1]
			local new_start_line = start_line:sub(1, start.col - 1) .. lhs .. start_line:sub(start.col)
			vim.api.nvim_buf_set_lines(0, start.line - 1, start.line, false, { new_start_line })

			local end_line = vim.api.nvim_buf_get_lines(0, fin.line - 1, fin.line, false)[1]
			local new_end_line = end_line:sub(1, fin.col) .. rhs .. end_line:sub(fin.col + 1)
			vim.api.nvim_buf_set_lines(0, fin.line - 1, fin.line, false, { new_end_line })
			vim.fn.setpos("'<", { 0, start.line, start.col + 1 })
		end
		vim.fn.feedkeys("gv h", "n")
	end, 5)
end

local function bind(...)
	local vararg = { ... }
	return function()
		return wrap_pairs(unpack(vararg))
	end
end

local pair_key = "S"

vim.keymap.set("v", pair_key .. "(", bind("(", ")"), {
	desc = "Wrap () around selection",
})
vim.keymap.set("v", pair_key .. "[", bind("[", "]"), {
	desc = "Wrap [] around selection",
})
vim.keymap.set("v", pair_key .. "{", bind("{", "}"), {
	desc = "Wrap {} around selection",
})
vim.keymap.set("v", pair_key .. "<", bind("<", ">"), {
	desc = "Wrap <> around selection",
})
vim.keymap.set("v", pair_key .. '"', bind('"', '"'), {
	desc = 'Wrap "" around selection',
})
vim.keymap.set("v", pair_key .. "'", bind("'", "'"), {
	desc = "Wrap '' around selection",
})
vim.keymap.set("v", pair_key .. "`", bind("`", "`"), {
	desc = "Wrap `` around selection",
})
vim.keymap.set("v", pair_key .. "~", bind("`", "'"), {
	desc = "Wrap `' around selection",
})

return {}
