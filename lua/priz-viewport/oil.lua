---@diagnostic disable-next-line: undefined-global
local vim = vim

function PrizCloseOil()
    if vim.bo[0].filetype == "oil" then
        require("oil").close()
    end
end

function PrizkeymapToggleOil()
    if vim.bo[0].filetype == "oil" then
        require("oil").discard_all_changes()
        require("oil").close()
    else
        vim.cmd("Oil")
    end
end

return {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
        require("oil").setup({
            float = {
                padding = 8,
            },
        })

        vim.keymap.set("n", "<leader>n", ":lua PrizkeymapToggleOil()<CR>", {
            desc = "Oil",
            noremap = true,
            silent = true
        })
    end,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}
