return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
        require("catppuccin").setup({
            flavour = "latte",
            term_colors = true,
            transparent_background = false,
            show_end_of_buffer = true,
            dim_inactive = {
                enabled = true,
                shade = "light",
            },
        })
        vim.cmd.colorscheme("catppuccin")
    end,
}
