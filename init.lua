vim.opt.number = true                                                           -- Show line numbers
vim.opt.mouse = "a"                                                             -- enable mouse
vim.opt.ignorecase = true                                                       -- Ignore case when searching
vim.opt.smartcase = true                                                        -- Notice case when search term contains uppercase letter
vim.opt.wrap = true                                                             -- Line wrapping
vim.opt.breakindent = true                                                      -- Line wrap on same level
vim.opt.linebreak = true                                                        -- Break lines at word boundaries
vim.opt.relativenumber = true                                                   -- Relative line numbers

local _tab = 4
local _nib = _tab / 2
vim.opt.tabstop = _tab                                                          -- Tab stops
vim.opt.shiftwidth = _tab                                                       -- How far to indent
vim.opt.expandtab = true                                                        -- Use spaces indstead of tabs
vim.opt.showbreak = string.rep("~", _nib) .. "~>" .. string.rep(" ", _nib)      -- Show this character when line wraps

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "priz-lazy",
})


-- Use system clipboard
vim.opt.clipboard = "unnamedplus"
