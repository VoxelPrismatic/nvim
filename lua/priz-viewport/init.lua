---@diagnostic disable-next-line: undefined-global
local vim = vim

return {
    {
        "voxelprismatic/rosepine-neovim",
        name = "rose-pine",
        priority = 1000,
        lazy = false,
        config = function()
            require("rose-pine").setup({
                highlight_groups = {
                    IndentLine = { fg = "highlight_high" },
                    IndentLineCurrent = { fg = "iris" },
                },
            })
            vim.cmd.colorscheme("rose-pine-dawn")
        end,
    },
}

