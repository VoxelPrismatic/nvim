return { ---@type LazyPluginSpec
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = true,
    cmd = "Lspsaga",
    opts = { ---@type LspsagaConfig
        ui = {
            lines = { "╰", "├", "│", "─", "╭" },
            expand = "",
            collapse = "",
            code_action = "󱐋",
            imp_sign = "",
        },
        symbol_in_winbar = {
            enable = true,
        },
        code_action = {
            only_in_cursor = true,
            keys = {
                exec = "<CR>",
                quit = "<Esc>"
            },
        },
        lightbulb = {
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
    },
    keys = {
        {
            "<leader>?", "<cmd>Lspsaga hover_doc<CR>",
            desc = "Get inline documentation",
        }, {
            "<leader>k<CR>", "<cmd>Lspsaga term_toggle<CR>",
            desc = "Toggle terminal",
        }, {
            "<leader>la", "<cmd>Lspsaga code_action<CR>",
            desc = "Code action",
        }, {
            "<leader>lr", "<cmd>Lspsaga rename<CR>",
            desc = "Rename token",
        }, {
            "<leader>lf", "<cmd>Lspsaga finder<CR>",
            desc = "Find token refs",
        }, {
            "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>",
            desc = "Line diagnostics",
        }, {
            "<leader>lo", "<cmd>Lspsaga outline<CR>",
            desc = "Outline",
        }, {
            "<leader>lj", "<cmd>Lspsaga goto_definition<CR>",
            desc = "Jump to declaration",
        }, {
            "<leader>lt", "<cmd>Lspsaga goto_type_definition<CR>",
            desc = "Jump to struct",
        }, {
            "<leader>lsj", "<cmd>Lspsaga peek_definition<CR>",
            desc = "Peek declaration",
        }, {
            "<leader>lst", "<cmd>Lspsaga peek_type_definition<CR>",
            desc = "Peek struct",
        },
    },
    init = function()
        require("which-key").add({
            "<leader>l",
            group = "Saga",
        }, {
            "<leader>k",
            group = "+Saga"
        })
    end,
}

