return { ---@type LazyPluginSpec
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    branch = "0.1.x",
    lazy = true,
    config = true,
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    opts = {
        extentions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            live_grep_args = {},
        },
    },
    keys = {
        {
            "<leader>tf", function()
                PrizCloseOil()
                vim.cmd("Telescope find_files")
            end,
            mode = "n",
            desc = "Find files",
            noremap = true,
            silent = true,
        },
        {
            "<leader>tg", function()
                PrizCloseOil()
                vim.cmd("Telescope live_grep_args")
            end,
            mode = "n",
            desc = "Live grep",
            noremap = true,
            silent = true,
        },
        {
            "<leader>tb", function()
                PrizCloseOil()
                vim.cmd("Telescope buffers")
            end,
            mode = "n",
            desc = "Find buffers",
            noremap = true,
            silent = true,
        },
        {
            "<leader>tt", function()
                PrizCloseOil()
                vim.cmd("Telescope")
            end,
            mode = "n",
            desc = "Launch telescope",
            noremap = true,
            silent = true,
        },
    },
    init = function()
        require("which-key").register({
            ["<leader>t"] = {
                name = "+Telescope",
            },
        })
    end,

}
