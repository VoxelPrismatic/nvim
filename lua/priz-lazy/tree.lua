---@diagnostic disable-next-line: undefined-global
local vim = vim

function PrizCloseOil()
    if vim.bo[0].filetype == "oil" then
        require("oil").close()
    end
end

function PrizkeymapToggleOil()
    if vim.bo[0].filetype == "oil" then
        require("oil").close()
    else
        vim.cmd("Oil")
    end
end

return {
    -- File tree
    --[[ {
        "nvim-tree/nvim-tree.lua",
        config = function()
            local api = require("nvim-tree.api")
            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    noremap = true,
                    buffer = bufnr,
                    silent = true,
                    nowait = true,
                }
            end
           require("nvim-tree").setup({
                view = { width = 40 },
                sync_root_with_cwd = true,
                on_attach = function(bufnr)
                    api.config.mappings.default_on_attach(bufnr)
                    vim.keymap.set("n", "<C-BS>", api.tree.change_root_to_parent, opts("Up"))
                    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
                end,
            })
            vim.keymap.set("n", "<leader>n", api.tree.toggle, opts("Toggle"))

        end,
    },
]]

    -- File tree
    {
        "stevearc/oil.nvim",
        event = "VeryLazy",
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
    },
    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup()
        end,
    },
}
