local ns = {
	ident = vim.api.nvim_create_namespace(":indents:"),
	cursor = vim.api.nvim_create_namespace(":cursor:"),
	bar = vim.api.nvim_create_namespace(":indent-bar:"),
}

---@return string
local function tabChar()
	local tabstop = vim.o.tabstop
	local tabparts = vim.fn.str2list(vim.opt.listchars:get().tab)
	for i, v in ipairs(tabparts) do
		tabparts[i] = vim.fn.nr2char(v)
	end

	local tab = ""
	if #tabparts == 1 then
		tab = tabparts[1]:rep(tabstop)
	elseif #tabparts == 2 then
		tab = tabparts[1] .. tabparts[2]:rep(tabstop - 1)
	elseif #tabparts >= 3 then
		tab = tabparts[1] .. tabparts[2]:rep(tabstop - 2) .. tabparts[3]
	else
		tab = (" "):rep(tabstop)
	end

	return tab
end

function HlLeftmostIndent()
	local tabstop = vim.o.tabstop
	local curline = vim.fn.line(".")
	local curcol = vim.fn.col(".")

	local buftext = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local indent = "\t"
	local realline = curline
	while buftext[realline]:gsub("^%s+", "") == "" do
		realline = realline - 1
		if buftext[realline] == nil then
			return
		end
	end

	if buftext[realline]:sub(1, 1) ~= "\t" then
		indent = (" "):rep(tabstop)
	end

	local level = 0
	local len = #indent

	while buftext[realline]:sub(level * len + 1, (level + 1) * len) == indent do
		level = level + 1
	end

	if realline == curline and curcol <= level * len then
		level = math.min(level, math.floor(curcol / len))
	end

	local str = indent:rep(level)
	len = #str

	for _, id in pairs(ns) do
		vim.api.nvim_buf_clear_namespace(0, id, 0, -1)
	end

	local pointer = { "⚞", "⚟" }
	if curcol > len + 1 then
		pointer = {}
	elseif curcol <= 1 then
		table.remove(pointer, 1)
	elseif curcol > len then
		table.remove(pointer, #pointer)
	end

	if #pointer > 0 then
		vim.api.nvim_buf_set_extmark(0, ns.cursor, curline - 1, 0, {
			virt_text_win_col = math.max(0, (curcol - 1) * (indent == "\t" and tabstop or 1) - 1),
			virt_text = {
				{ table.concat(pointer, ""), { "EndOfBuffer", "CursorLine" } },
			},
			priority = 3,
			strict = false,
		})
	end

	if level == 0 then
		return
	end

	local tab = tabChar()
	local linelens = {}

	local function printTabs(line, count)
		vim.api.nvim_buf_set_extmark(0, ns.ident, line - 1, 0, {
			virt_text = { { tab:rep(count), { "Whitespace", line == curline and "CursorLine" or nil } } },
			virt_text_pos = "overlay",
			priority = 1,
		})
	end

	---@param dir integer
	---@return integer
	local function iline(dir)
		local i = realline
		while true do
			local line = buftext[i + dir]
			if line == nil then
				break
			end

			local start = line:gsub("^%s", "")
			linelens[i] = vim.fn.strdisplaywidth(line)

			if start == "" then
				i = i + dir
				printTabs(i, level)
			elseif line:sub(1, len) == str then
				i = i + dir
				if indent ~= "\t" then
					printTabs(i, (#line - #start) / tabstop + 1)
				end
			else
				break
			end
		end

		while linelens[i] == 0 do
			i = i - dir
		end

		return i
	end

	local prevline = iline(-1)
	local nextline = iline(1)

	local wcol = len - #indent
	if indent == "\t" then
		wcol = wcol * tabstop
	end

	local seq = (nextline - prevline) >= 2 and { "🯔", "🯕", "🯖", "🯗" } or { "⸾" }
	for i = prevline, nextline do
		vim.api.nvim_buf_set_extmark(0, ns.bar, i - 1, 0, {
			virt_text_win_col = wcol,
			virt_text = {
				{ seq[i % #seq + 1], { "Special", i == curline and "CursorLine" or nil } },
			},
			priority = 2,
			strict = false,
		})
	end
end

vim.api.nvim_create_augroup("PrizIndent", {
	clear = false,
})
if #vim.api.nvim_get_autocmds({ group = "PrizIndent" }) == 0 then
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		callback = function()
			HlLeftmostIndent()
		end,
	})
end

return {}
