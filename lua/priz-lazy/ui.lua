---@diagnostic disable-next-line: undefined-global
local vim = vim

return {
    -- Code folding
    {
        "kevinhwang91/nvim-ufo",
        event = "VeryLazy",
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
                provider_selector = function(bufnr, filetype, buftype)
                    return {"treesitter", "indent"}
                end
            })
        end,
    },

    -- Also code folding
    {
        "nvim-treesitter/nvim-treesitter",
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

    -- Icons and things
    {
        "ryanoasis/vim-devicons",
        name = "nvim-web-devicons",
    },

    -- Colorizer, eg #00ffff
    {
        "NvChad/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("colorizer").setup()
        end,
    },

    -- Which key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
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
    },

    -- Indent bars
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        config = function()
            require("ibl").setup()
        end,
    },
}
