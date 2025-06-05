vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	callback = function()
		vim.o.expandtab = false
		vim.o.tabstop = 4
		vim.o.shiftwidth = 4
	end,
})

return {}
