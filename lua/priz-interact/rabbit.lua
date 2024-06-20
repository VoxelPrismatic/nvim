return { ---@type LazyPluginSpec
    "voxelprismatic/rabbit.nvim",
    lazy = false,
    config = true,
    cmd = "Rabbit",
    keys = {{
        "<leader>r", function() require("rabbit").Window("history") end,
        mode = "n",
        desc = "Open Rabbit",
    }},
    opts = { ---@type Rabbit.Options
        colors = {
            term = { fg = "#40c9a2", italic = true },
            message = { fg = "#8aaacd", italic = true, bold = true },
        },
        window = {
            plugin_name_position = "title",
        },
    },
}
