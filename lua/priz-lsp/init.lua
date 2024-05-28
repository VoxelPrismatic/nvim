return {
    {
        "neovim/nvim-lspconfig",
        lazy = { "LazyFile", "InsertEnter" },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(_)
                    end,
                },
                mapping = {
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<F4>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<F3>"] = cmp.mapping.close(),
                    ["<F2>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<F1>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = "BufEnter",
    },
    {
        "folke/neodev.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("neodev").setup()
        end,
    },
}
