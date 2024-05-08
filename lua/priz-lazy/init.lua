---@diagnostic disable-next-line: undefined-global
local vim = vim

return {
    -- Because sometimes I"m lazy as hell
    {
        "Exafunction/codeium.vim",
        event = "BufEnter",
    },

    {
        "ThePrimeagen/vim-be-good",
        event = "VeryLazy",
    },

    -- No more autopairs! I find that I"m fighting with it too much


    -- Quick comments
    {
        "numToStr/Comment.nvim",
        event = "BufEnter",
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
        init = function()
            vim.keymap.set("i", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", {
                desc = "Toggle comment",
                noremap = true,
                silent = true,
            })
        end,
    },

    -- Undo trees may be useful
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        init = function()
            vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", {
                desc = "Undo tree", silent = true
            })
        end,
    },--
}
