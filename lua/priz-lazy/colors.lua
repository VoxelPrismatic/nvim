---@diagnostic disable-next-line: undefined-global
local vim = vim

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.cmd("hi NormalNC guibg=" .. require("rose-pine.palette").overlay)
    end
})

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        lazy = false,
        config = function()
            require("rose-pine").setup({
                variant = "dawn",
                dark_variant = "moon",
            })
            vim.cmd.colorscheme("rose-pine")
        end,
    },
    {
        "tpope/vim-markdown",
        lazy = false,
    }
}

