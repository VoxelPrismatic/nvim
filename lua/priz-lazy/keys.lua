---@diagnostic disable-next-line: undefined-global
local vim = vim

-- Set leader key
vim.g.mapleader = "\\"

-- Open a new buffer
vim.keymap.set("n", "<leader>b", ":enew<CR>", {
    desc = "New buffer",
    noremap = true,
    silent = true
})

-- Close current buffer
vim.keymap.set("n", "<leader>c", ":bd<CR>", {
    desc = "Close buffer",
    noremap = true,
    silent = true
})

-- Clear highlights
vim.keymap.set("n", "<leader>\\", ":noh<CR>", {
    desc = "Clear highlights",
    noremap = true,
    silent = true
})

-- Unset function keys
for i = 1, 12 do
    vim.keymap.set("n", "<F" .. i .. ">", "<Nop>", { noremap = true, silent = true })
    vim.keymap.set("i", "<F" .. i .. ">", "<Nop>", { noremap = true, silent = true })
end

-- Remap home key
---- Behavor:
---- 1. If cursor is at the beginning of the line, move to the first non-blank character
---- 2. If cursor is at the first non-blank character, move to the beginning of the line

vim.keymap.set("n", "<Home>", ":lua PrizkeymapToggleHome()<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<Home>", "<Esc>:lua PrizkeymapToggleHome()<CR>i", { noremap = true, silent = true })

function PrizkeymapToggleHome()
    local current_line = vim.fn.line(".")
    local first_non_blank = vim.fn.match(vim.fn.getline(current_line), "\\S")
    if vim.fn.col(".") == first_non_blank then
        vim.cmd("normal! 0")
    elseif vim.fn.col(".") == (first_non_blank + 1) then
        -- Sometimes it doesn"t work in normal mode
        vim.cmd("normal! 0")
    else
        vim.cmd("normal! ^")
    end
end

return {
    "willothy/moveline.nvim",
    build = "make",
    event = "BufEnter",
    config = function()
        local moveline = require("moveline")
        vim.keymap.set("n", "<M-k>", moveline.up)
        vim.keymap.set("n", "<M-j>", moveline.down)
        vim.keymap.set("v", "<M-k>", moveline.block_up)
        vim.keymap.set("v", "<M-j>", moveline.block_down)
    end
}
