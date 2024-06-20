-- Remap home key
---- Behavior:
---- 1. If cursor is at the beginning of the line, move to the first non-blank character
---- 2. If cursor is at the first non-blank character, move to the beginning of the line

local function toggle_home()
    local cur = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! ^")
    if vim.deep_equal(cur, vim.api.nvim_win_get_cursor(0)) then
        vim.cmd("normal! 0")
    end
end

vim.keymap.set({ "n", "v", "i" }, "<Home>", toggle_home, { noremap = true, silent = true })

-- PageUp and PageDown will stay in the center of the screen
vim.keymap.set({ "n", "v", "x" }, "<PageUp>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "x" }, "<PageDown>", "<C-d>zz", { noremap = true, silent = true })

vim.keymap.set("i", "<PageUp>", "<Esc><C-u>zz", { noremap = true, silent = true })
vim.keymap.set("i", "<PageDown>", "<Esc><C-d>zz", { noremap = true, silent = true })

return {}
