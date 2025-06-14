vim.opt.number = true -- Show line numbers
vim.opt.mouse = "a" -- Enable mouse
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Notice case when search term contains uppercase letter
vim.opt.wrap = false -- Line wrapping
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.list = true -- Show special characters

local _tab = 4 -- Set tab width
vim.opt.tabstop = _tab -- Tab stops
vim.opt.shiftwidth = _tab -- How far to indent
vim.opt.expandtab = false -- Use tabs instead of spaces

vim.opt.listchars = {
	trail = "·", -- Trailing spaces
	tab = "│─┄", -- Tabs
}

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "priz-custom" },
	{ import = "priz-viewport" },
	{ import = "priz-lsp" },
	{ import = "priz-interact" },
	{ import = "priz-lang" },
	{ import = "priz-games" },
})

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"
vim.fn.delete(vim.lsp.log.get_filename())
