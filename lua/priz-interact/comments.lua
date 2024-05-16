return {
    "numToStr/Comment.nvim",
    event = "UIEnter",
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
}
