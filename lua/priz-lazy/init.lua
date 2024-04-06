return {
    -- Because sometimes I'm lazy as hell
    {
        "github/copilot.vim",
        lazy = false,
    },

    -- And in case I'm not lazy enough
    --[[{
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },--]]

    -- Because I'm too lazy to type the whole thing
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        branch = "0.1.x",
        dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })
        end,
        init = function()
            vim.keymap.set("n", "<leader>t", ":Telescope find_files<CR>", { desc = "Find files", silent = true })
        end,
    },

    -- Taking lazy to the nect level with this one
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        after = "telescope.nvim",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },

    -- Quick comments
    {
        'numToStr/Comment.nvim',
        opts = {
            toggler = {
                line = "<leader>/",
                block = "<leader>]",
            },
            opleader = {
                line = "<leader>/",
                block = "<leader>]",
            },
        },
        lazy = false,
    },

    -- Undo trees may be useful
    --[[{
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        init = function()
            vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Undo tree", silent = true })
        end,
    },--]]
}
