local exe = {
	stylua = "stylua --syntax=LuaJIT",
	clang_format = "clang-format --style=file -i",
	prettier = "prettier -w",
}

local formatters = {
	-- c = exe.clang_format,
	java = exe.clang_format,
	markdown = exe.prettier,
	html = exe.prettier,
	lua = exe.stylua,
}

-- Delete trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	desc = "Delete trailing spaces on save, and format file",
	callback = function(evt)
		vim.cmd([[%s/\s\+$//e]])
		if formatters[vim.bo[evt.buf].filetype] ~= nil then
			return
		end

		local clients = vim.lsp.get_clients({
			bufnr = evt.buf,
			method = "textDocument/formatting",
		})

		if #clients > 0 then
			vim.lsp.buf.format()
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*" },
	desc = "Format file post-save",
	callback = function(evt)
		local cb = formatters[vim.bo[evt.buf].filetype]

		if cb ~= nil then
			vim.cmd("silent! !" .. cb .. " %")
		end
	end,
})

return {}
