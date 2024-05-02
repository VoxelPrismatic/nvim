---@diagnostic disable-next-line: undefined-global
local vim = vim

return {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    config = function()
        require("rose-pine").setup({
            variant = "dawn",
            dark_variant = "moon",

            -- styles = {
                -- transparency = true,
            -- },
        })
        vim.cmd.colorscheme("rose-pine")
    end,
}
