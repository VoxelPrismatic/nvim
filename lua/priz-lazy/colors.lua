return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
            term_colors = true,
            dim_inactive = {
                enabled = true,
                shade = "light",
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end,
}
