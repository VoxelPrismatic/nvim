vim.keymap.set("n", "<leader>s<Up>", ":hor abo sp +bNext<CR>", {
    desc = "Add split above",
    noremap = true,
    silent = true,
})

vim.keymap.set("n", "<leader>s<Down>", ":hor bel sp +bNext<CR>", {
    desc = "Add split below",
    noremap = true,
    silent = true,
})

vim.keymap.set("n", "<leader>s<Left>", ":vert lefta sp +bNext<CR>", {
    desc = "Add split left",
    noremap = true,
    silent = true,
})

vim.keymap.set("n", "<leader>s<Right>", ":vert rightb sp +bNext<CR>", {
    desc = "Add split right",
    noremap = true,
    silent = true,
})

return {}

