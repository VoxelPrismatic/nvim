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
    opts = { ---@type RabbitOptions
        colors = {
            term = { fg = "#34ab7e", italic = true },
        },
        window = {
            plugin_name_position = "title",
        },
    },
}
