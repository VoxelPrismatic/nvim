return { ---@type LazyPluginSpec
    "willothy/moveline.nvim",
    build = "make",
    lazy = true,
    keys = {
        {
            "<M-k>", function() require("moveline").up() end,
            mode = { "n", "i" },
            desc = "Move line up"
        },
        {
            "<M-j>", function() require("moveline").down() end,
            mode = { "n", "i" },
            desc = "Move line down"
        },
        {
            "<M-k>", function() require("moveline").block_up() end,
            mode = { "v" },
            desc = "Move block up"
        },
        {
            "<M-j>", function() require("moveline").block_down() end,
            mode = { "v" },
            desc = "Move block down"
        },
    },
}
