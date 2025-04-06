local formatters = {
	lua = "stylua",
}
-- Delete trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	desc = "Delete trailing spaces on save, and format file",
	callback = function()
		vim.cmd([[%s/\s\+$//e]])
		if formatters[vim.bo.filetype] == nil then
			vim.lsp.buf.format()
		end
	end,
})

for k, v in pairs(formatters) do
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "*." .. k },
		callback = function()
			vim.cmd("silent! !" .. v .. " %")
		end,
		desc = "Format after save for " .. k,
	})
end

return {}
