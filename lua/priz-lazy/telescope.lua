---@diagnostic disable-next-line: undefined-global
local vim = vim

function PrizTelescopeLaunch(arg)
    PrizCloseOil()
    vim.cmd("Telescope " .. arg)
end

return {
    -- Because I'm too lazy to type the whole thing
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        branch = "0.1.x",
        event = "VeryLazy",
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
            vim.keymap.set("n", "<leader>tf", ":lua PrizTelescopeLaunch(\"find_files\")<CR>", {
                desc = "Find files",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>tg", ":lua PrizTelescopeLaunch(\"live_grep_args\")<CR>", {
                desc = "Live grep",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>tb", ":lua PrizTelescopeLaunch(\"buffers\")<CR>", {
                desc = "Find buffers",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>tt", ":lua PrizTelescopeLaunch(\"\")<CR>", {
                desc = "Launch telescope",
                noremap = true,
                silent = true,
            })
        end,
    },

    -- Taking lazy to the nect level with this one
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        after = "telescope.nvim",
        event = "VeryLazy",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
}
