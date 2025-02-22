return { ---@type LazyPluginSpec
    "folke/which-key.nvim",
    lazy = true,
    config = function()
        local wk = require("which-key")
        wk.setup({
            icons = {
                separator = "~",
            },
        })
        wk.add({
            { "<leader>s", name = "Split Win" },
            { "<leader>S", name = "Copy Buf" },
            { "<leader>k", name = "Term" },
        })
    end,
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
}
