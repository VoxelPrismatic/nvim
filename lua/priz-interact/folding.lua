return {
    {
        "kevinhwang91/nvim-ufo",
        event = { "VeryLazy" },
        dependencies = {
            "kevinhwang91/promise-async",
        },
        config = function()
            vim.o.foldcolumn = "0"  -- No fold column; difficult to make out relative line numbers
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.foldenable = true

            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
            vim.keymap.set("n", "zq", "za", { desc = "Toggle fold" })   -- za is too close to be comfortable

            require("ufo").setup({
                provider_selector = function(_, _, _)
                    return {"treesitter", "indent"}
                end
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = { "VeryLazy" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "markdown",
                    "markdown_inline",
                },
                auto_install = true,
                indent = {
                    enable = true,
                },
            })
        end,
    },
}
