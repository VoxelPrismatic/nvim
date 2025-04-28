vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(evt)
		if vim.fn.buflisted(evt.buf) ~= 1 then
			return
		end

		require("git-conflict").refresh(evt.buf)
	end,
})

---@param bufnr integer
local function buf_conflict_choose_hover(bufnr)
	local conflicts = require("git-conflict").positions(bufnr) or {}

	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	---@param range Range
	local function in_range(range)
		return line >= (range.content_start or line + 1) and line <= (range.content_end or -1)
	end

	for _, conflict in ipairs(conflicts) do
		if in_range(conflict.current) then
			require("git-conflict.commands").buf_conflict_choose_current(bufnr)
			return
		elseif in_range(conflict.incoming) then
			require("git-conflict.commands").buf_conflict_choose_incoming(bufnr)
			return
		end
	end

	return function() end
end

vim.api.nvim_create_autocmd("User", {
	pattern = "GitConflict",
	callback = function(evt)
		local cmd = require("git-conflict.commands")

		---@param callback fun(bufnr: number)
		---@return fun()
		local function bind(callback)
			return function()
				callback(evt.buf)
			end
		end

		vim.keymap.set("n", "<leader>CC", bind(buf_conflict_choose_hover), {
			desc = "Retain current",
			buffer = evt.buf,
		})
		vim.keymap.set("n", "<leader>Cl", bind(cmd.buf_conflict_choose_current), {
			desc = "Retain local",
			buffer = evt.buf,
		})
		vim.keymap.set("n", "<leader>Cr", bind(cmd.buf_conflict_choose_incoming), {
			desc = "Retain remote",
			buffer = evt.buf,
		})
		vim.keymap.set("n", "<leader>Cx", bind(cmd.buf_conflict_choose_none), {
			desc = "Retain none",
			buffer = evt.buf,
		})
		vim.keymap.set("n", "<leader>Ca", bind(cmd.buf_conflict_choose_both), {
			desc = "Retain both",
			buffer = evt.buf,
		})
	end,
})

return { ---@type LazyPluginSpec
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		keys = {
			{ "<leader>g", "<cmd>LazyGit<cr>", mode = "n", desc = "LazyGit" },
		},
	},
	{
		"konradmalik/git-conflict.nvim",
		lazy = false,
		version = "*",
		config = function(conf)
			require("git-conflict").setup(conf.opts)
			require("which-key").add({
				{ "<leader>C", name = "Git Conflict" },
			})

			local cmd = require("git-conflict.commands")

			vim.keymap.set("n", "<leader>C]", cmd.buf_next_conflict, {
				desc = "Next conflict",
			})
			vim.keymap.set("n", "<leader>[", cmd.buf_prev_conflict, {
				desc = "Previous conflict",
			})
		end,
	},
}
