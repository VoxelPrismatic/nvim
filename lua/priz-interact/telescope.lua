---@diagnostic disable-next-line: undefined-global
local vim = vim

function PrizTelescopeLaunch(arg)
    PrizCloseOil()
    vim.cmd("Telescope " .. arg)
end

return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        event = "UIEnter",
        after = "telescope.nvim",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        config = function()
            require("telescope").load_extension("live_grep_args")
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
            require("which-key").register({
                ["<leader>"] = {
                    t = {
                        name = "+Telescope",
                    },
                },
            })
            vim.keymap.set("n", "<leader>tf", "<cmd>lua PrizTelescopeLaunch(\"find_files\")<CR>", {
                desc = "Find files",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>tg", "<cmd>lua PrizTelescopeLaunch(\"live_grep_args\")<CR>", {
                desc = "Live grep",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>tb", "<cmd>lua PrizTelescopeLaunch(\"buffers\")<CR>", {
                desc = "Find buffers",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>tt", "<cmd>lua PrizTelescopeLaunch(\"\")<CR>", {
                desc = "Launch telescope",
                noremap = true,
                silent = true,
            })
        end,

    }
}
