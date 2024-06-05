-- Remap home key
---- Behavior:
---- 1. If cursor is at the beginning of the line, move to the first non-blank character
---- 2. If cursor is at the first non-blank character, move to the beginning of the line

local function toggle_home()
    local current_line = vim.fn.line(".")
    local first_non_blank = vim.fn.match(vim.fn.getline(current_line), "\\S")
    if vim.fn.col(".") == first_non_blank then
        vim.cmd("normal! 0")
    elseif vim.fn.col(".") == (first_non_blank + 1) then
        -- Sometimes it doesn't work in normal mode
        vim.cmd("normal! 0")
    else
        vim.cmd("normal! ^")
    end
end

vim.keymap.set({ "n", "v", "i" }, "<Home>", toggle_home, { noremap = true, silent = true })

return {}
