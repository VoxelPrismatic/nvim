return {
    "voxelprismatic/rabbit.nvim",
    config = function()
        require("rabbit").setup({
            colors = {
                term = { fg = "#34ab7e", italic = true },
            },
            window = {
                plugin_name_position = "title",
            },
        })
    end,
}
