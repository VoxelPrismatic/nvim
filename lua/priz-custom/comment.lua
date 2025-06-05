local function perform_comment(start, end_)
	local str = vim.bo.commentstring:gsub("%%s", "")
	if str == "" then
		vim.notify("No comment string for `" .. vim.bo.filetype .. "'", vim.log.levels.ERROR)
		return
	end

	local all_commented = true
	local lines = vim.api.nvim_buf_get_lines(0, start - 1, end_, false)
	for _, line in ipairs(lines) do
		if line:gsub("^%s+", ""):find(str) ~= 1 then
			all_commented = false
			break
		end
	end

	for i, line in ipairs(lines) do
		local head, tail = line:match("^(%s*)(.*)")

		if all_commented then
			tail = string.sub(tail, #str + 1)
			lines[i] = head .. tail
		else
			lines[i] = head .. str .. tail
		end
	end

	vim.api.nvim_buf_set_lines(0, start - 1, end_, false, lines)
end

local function toggle_comment()
	local mode = vim.fn.mode()
	if mode == "n" then
		local cur = vim.fn.line(".")
		perform_comment(cur, cur)
		return
	end

	vim.fn.feedkeys("")
	vim.defer_fn(function()
		local start = vim.fn.line("'<")
		local end_ = vim.fn.line("'>")
		perform_comment(start, end_)
	end, 5)
end

vim.keymap.set({ "n", "v" }, "<leader>/", toggle_comment, { noremap = true, silent = true })

return {}
