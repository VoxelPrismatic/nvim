-- Set leader key
vim.g.mapleader = "\\"

-- Open a new buffer
vim.keymap.set("n", "<leader>b", "<cmd>enew<CR>", {
    desc = "New buffer",
    noremap = true,
    silent = true
})

-- Close current buffer
vim.keymap.set("n", "<leader>c", "<cmd>bd<CR>", {
    desc = "Close buffer",
    noremap = true,
    silent = true
})

-- Clear highlights
vim.keymap.set("n", "<leader>\\", "<cmd>noh<CR>", {
    desc = "Clear highlights",
    noremap = true,
    silent = true
})

-- Delete next word
vim.keymap.set("i", "<C-e>", "<C-o>dw", {
    desc = "Delete next word",
    noremap = true,
    silent = true
})



-- Unset function keys
for i = 1, 12 do
    vim.keymap.set("n", "<F" .. i .. ">", "<Nop>", { noremap = true, silent = true })
    vim.keymap.set("i", "<F" .. i .. ">", "<Nop>", { noremap = true, silent = true })
end

return {}
