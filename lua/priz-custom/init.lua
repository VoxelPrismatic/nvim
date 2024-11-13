function CloseBuffer()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.cmd("w")
    require("oil").open()
    vim.api.nvim_buf_delete(bufnr, { force = true })
end

-- Set leader key
vim.g.mapleader = "\\"

-- Open a new buffer
vim.keymap.set("n", "<leader>b", "<cmd>enew<CR>", {
    desc = "New buffer",
    noremap = true,
    silent = true
})

-- Close current buffer
vim.keymap.set("n", "<leader>c", CloseBuffer, {
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
    vim.keymap.set({ "n", "i", "v" }, "<F" .. i .. ">", "<Nop>", {
        noremap = true,
        silent = true
    })
end

return {}
