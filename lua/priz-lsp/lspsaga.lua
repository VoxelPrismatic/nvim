return {
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({
                ui = {
                    lines = { "╰", "├", "│", "─", "╭" },
                    expand = "",
                    collapse = "",
                    code_action = "󱐋",
                },
                code_action_prompt = {
                    enable = false,
                },
                code_action_keys = {
                    quit = "<Esc>",
                    exec = "<CR>",
                },
                symbol_in_winbar = {
                    enable = true,
                },
                code_action = {
                    only_in_cursor = false,
                },
                lightbulb = {
                    icon = "󱐋",
                    debounce = 500,
                    virtual_text = false,
                    enable_in_insert = false,
                },
                finder = {
                    keys = {
                        quit = "<Esc>",
                        toggle_or_open = "<CR>",
                    },
                },
                implement = {
                    enable = true,
                },
            })
            vim.keymap.set("n", "<leader>?", "<cmd>Lspsaga hover_doc<CR>", {
                desc = "Get inline documentation",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga term_toggle<CR>", {
                desc = "Toggle terminal",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", {
                desc = "Code action",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", {
                desc = "Rename token",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", {
                desc = "Find token refs",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", {
                desc = "Line diagnostics",
                noremap = true,
                silent = true,
            })

            vim.keymap.set("n", "<leader>lj", "<cmd>Lspsaga goto_definition<CR>", {
                desc = "Jump to declaration",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>lt", "<cmd>Lspsaga goto_type_definition<CR>", {
                desc = "Jump to struct",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>lsj", "<cmd>Lspsaga peek_definition<CR>", {
                desc = "Peek declaration",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>lst", "<cmd>Lspsaga peek_type_definition<CR>", {
                desc = "Peek struct",
                noremap = true,
                silent = true,
            })


            require("which-key").register({
                ["<leader>"] = {
                    l = {
                        name = "+Saga",
                        s = { name = "+Peek" }
                    },
                },
            })
        end,
    },
}
