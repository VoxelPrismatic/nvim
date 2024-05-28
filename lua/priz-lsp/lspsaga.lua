local keybinds = {
    ["?"] = {
        "<cmd>Lspsaga hover_doc<CR>",
        "Get inline documentation",
    },
    ["k<CR>"] = {
        "<cmd>Lspsaga term_toggle<CR>",
        "Toggle terminal",
    },
    ["la"] = {
        "<cmd>Lspsaga code_action<CR>",
        "Code action",
    },
    ["lr"] = {
        "<cmd>Lspsaga rename<CR>",
        "Rename token",
    },
    ["lf"] = {
        "<cmd>Lspsaga finder<CR>",
        "Find token refs",
    },
    ["ld"] = {
        "<cmd>Lspsaga show_line_diagnostics<CR>",
        "Line diagnostics",
    },
    ["lo"] = {
        "<cmd>Lspsaga outline<CR>",
        "Outline",
    },
    ["lj"] = {
        "<cmd>Lspsaga goto_definition<CR>",
        "Jump to declaration",
    },
    ["lt"] = {
        "<cmd>Lspsaga goto_type_definition<CR>",
        "Jump to struct",
    },
    ["lsj"] = {
        "<cmd>Lspsaga peek_definition<CR>",
        "Peek declaration",
    },
    ["lst"] = {
        "<cmd>Lspsaga peek_type_definition<CR>",
        "Peek struct",
    },
}

return {
    {
        "nvimdev/lspsaga.nvim",
        event = { "LspAttach", "VeryLazy" },
        config = function()
            require("lspsaga").setup({
                ui = {
                    lines = { "╰", "├", "│", "─", "╭" },
                    expand = "",
                    collapse = "",
                    code_action = "󱐋",
                    actionfix = "",
                    imp_sign = "",
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
                outline = {
                    layout = "float",
                    max_height = 0.7,
                },
            })

            for k, v in pairs(keybinds) do
                vim.keymap.set("n", "<leader>" .. k, v[1], { desc = v[2], noremap = true, silent = true })
            end

            require("which-key").register({
                ["<leader>"] = {
                    l = {
                        name = "+Saga",
                        s = { name = "+Peek" }
                    },
                    k = {
                        name = "+Term",
                    }
                },
            })
        end,
    },
}
