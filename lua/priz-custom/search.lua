local function yank_and_search()
	vim.fn.feedkeys("", "n")
	vim.defer_fn(function()
		local start = { line = vim.fn.line("'<"), col = vim.fn.col("'<") }
		local fin = { line = vim.fn.line("'>"), col = vim.fn.col("'>") }
		local lines = vim.api.nvim_buf_get_lines(0, start.line - 1, fin.line, false)
		assert(#lines > 0, "???")
		if #lines > 1 then
			lines[1] = lines[1]:sub(start.col)
			lines[#lines] = lines[#lines]:sub(1, fin.col)
		else
			lines[1] = lines[1]:sub(start.col, fin.col)
		end
		local text = table.concat(lines, " ")

		vim.fn.setreg("/", text)
		vim.o.hlsearch = true
	end, 15)
end

vim.keymap.set("v", "/", yank_and_search, {
	desc = "Search for selection",
})

return {}
