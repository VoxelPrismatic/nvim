vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = {"*.py"},
    command = "silent! !autopep8 -i %",
})

return {}
