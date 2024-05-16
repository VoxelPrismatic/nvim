return {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
        local wk = require("which-key")
        wk.setup({
            icons = {
                separator = "~",
            },
        })
        wk.register({
            ["<leader>"] = {
                s = {
                    name = "+Split",
                },
            },
        })
    end,
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
}
