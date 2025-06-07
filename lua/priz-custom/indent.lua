local ns = vim.api.nvim_create_namespace(":indents:")
local ns2 = vim.api.nvim_create_namespace(":indents2:")
local lastLevel = 0

local function highlightCursor(curcol, curline, len, tabstop)
	vim.api.nvim_buf_clear_namespace(0, ns2, 0, -1)
	local tabparts = vim.fn.str2list(vim.opt.listchars:get().tab)
	for i, v in ipairs(tabparts) do
		tabparts[i] = vim.fn.nr2char(v)
	end

	if curcol <= len + 1 and 1 < curcol then
		pcall(vim.api.nvim_buf_set_extmark, 0, ns2, curline - 1, curcol - 2, {
			virt_text = {
				{ tabparts[1] .. tabparts[2]:rep(tabstop - 2), { "Whitespace", "CursorLine" } },
				{ "⚞", { "EndOfBuffer", "CursorLine" } },
			},
			virt_text_pos = "overlay",
			priority = 0,
		})
	end

	if curcol <= len then
		pcall(vim.api.nvim_buf_set_extmark, 0, ns2, curline - 1, curcol - 1, {
			virt_text = {
				{ "⚟", { "EndOfBuffer", "CursorLine" } },
			},
			virt_text_pos = "overlay",
			priority = 3,
		})
	end
end

function HlLeftmostIndent()
	local curline = vim.fn.line(".")
	local curcol = vim.fn.col(".")
	local tabstop = vim.o.tabstop

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

	highlightCursor(curcol, curline, len, tabstop)
	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
	if level == 0 then
		return
	end

	local prevline = realline
	while true do
		local line = buftext[prevline - 1]
		if line == nil then
			break
		elseif line:gsub("^%s+", "") == "" or line:sub(1, len) == str then
			prevline = prevline - 1
		else
			break
		end
	end

	local nextline = realline
	while true do
		local line = buftext[nextline + 1]
		if line == nil then
			break
		elseif line:gsub("^%s+", "") == "" or line:sub(1, len) == str then
			nextline = nextline + 1
		else
			break
		end
	end

	local seq = (nextline - prevline) >= 2 and { "🯔", "🯕", "🯖", "🯗" } or { "⸾" }
	for i = prevline, nextline do
		pcall(vim.api.nvim_buf_set_extmark, 0, ns, i - 1, len - 1, {
			virt_text = { { seq[i % #seq + 1], { "Special", i == curline and "CursorLine" or nil } } },
			virt_text_pos = "overlay",
			priority = 1,
		})
	end
end

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	callback = HlLeftmostIndent,
})

return {}
