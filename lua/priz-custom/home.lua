-- Remap home key
---- Behavior:
----- 1. If cursor is at the beginning of the line, move to the first non-blank character
----- 2. If cursor is at the first non-blank character, move to the beginning of the line

-- Scrolls the screen (n) lines and centers the cursor (like zz)
---@param n number Number of lines to scroll (-n to scroll up)
---@param dur number Animation duration
---@param center? boolean Center cursor after scroll
function Scroll(n, dur, center)
	local cb = function(k) return function() vim.fn.feed_termcodes(k, "n") end end
	local h = math.ceil(vim.fn.winheight(0) / 2) - 1

	-- Scrolling in insert mode produces obscure behavior
	local ret_i = false
	if vim.fn.mode() == "i" then
		cb("<Esc>")()
		ret_i = true
	end

	local cur_now = vim.fn.line(".")
	local top_now = vim.fn.line("w0")
	local buf_end = vim.fn.line("$")

	local cur_fin = math.max(1, math.min(buf_end, cur_now + n))
	local top_fin = math.max(1, math.min(buf_end, cur_fin - h))

	local top_diff = math.abs(top_now - top_fin)
	local cur_diff = math.abs(cur_now - cur_fin)

	local screen = top_now >= top_fin and cb("<C-y>") or cb("<C-e>")
	local arrow = cur_now >= cur_fin and cb("<Up>") or cb("<Down>")

	for i = 1, cur_diff do
		vim.defer_fn(arrow, i * dur / cur_diff)
	end

	if center == false then
		return
	end

	for i = 1, top_diff do
		vim.defer_fn(screen, i * dur / top_diff)
	end

	if ret_i then
		vim.defer_fn(cb("i"), dur)
	end
end

local function toggle_home()
	local cur = vim.api.nvim_win_get_cursor(0)
	vim.cmd("normal! 0") -- Always show the first column
	vim.cmd("normal! ^")
	if vim.deep_equal(cur, vim.api.nvim_win_get_cursor(0)) then
		vim.cmd("normal! 0")
	end
end

vim.keymap.set({ "n", "v", "i" }, "<Home>", toggle_home, { noremap = true, silent = true })

-- PageUp and PageDown will stay in the center of the screen
local ani_time = 50
vim.keymap.set(
	{ "n", "v", "x", "i" },
	"<PageUp>",
	function() Scroll(-vim.fn.winheight(0) / 2, ani_time) end,
	{ noremap = true, silent = true }
)
vim.keymap.set(
	{ "n", "v", "x", "i" },
	"<PageDown>",
	function() Scroll(vim.fn.winheight(0) / 2, ani_time) end,
	{ noremap = true, silent = true }
)

return {}
