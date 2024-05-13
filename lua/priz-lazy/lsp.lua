---@diagnostic disable-next-line: undefined-global
local vim = vim

local capabilities = vim.lsp.protocol.make_client_capabilities()

local _py_ignore = {
    "E251",     -- unexpected spaces around keyword / parameter equals
    "W293",     -- blank line contains whitespace
    "W391",     -- blank line at end of file
}
local _linelen = 120

local servers = {
    pylsp = {
        pylsp = {
            plugins = {
                jedi_completion = {
                    include_class_objects = true,
                    include_function_objects = true,
                    fuzzy = true,
                    eager = true,
                },
                flake8 = {
                    maxLineLength = _linelen,
                    ignore = _py_ignore,
                },
                pycodestyle = {
                    maxLineLength = _linelen,
                    ignore = _py_ignore,
                },
            },
        },
    },
}

-- Delete trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*"},
    command = [[%s/\s\+$//e]],
})

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufEnter" },
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        event = "BufEnter",
    },
    {
        "hrsh7th/cmp-buffer",
        event = "BufEnter",
    },
    {
        "hrsh7th/cmp-path",
        event = "BufEnter",
    },
    {
        "hrsh7th/cmp-cmdline",
        event = "BufEnter",
    },
    {
        "hrsh7th/nvim-cmp",
        event = "BufEnter",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(_)
                        -- vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<F4>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<F3>"] = cmp.mapping.close(),
                    ["<F2>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<F1>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    -- { name = "cmdline" },
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        event = { "BufReadPre", "BufEnter" },
        name = "mason",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufEnter" },
        name = "mason-lspconfig",
        config = function()
            local lsp = require("mason-lspconfig")
            lsp.setup({
                ensure_installed = {
                    "pylsp",
                },
                automatic_installation = true,
            })
            lsp.setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        settings = servers[server_name],
                        flags = { debounce_text_changes = 300 },
                    })
                end,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = "BufEnter",
    },
    {
        "nvimdev/lspsaga.nvim",
        event = { "LspAttach", "VeryLazy" },
        config = function()
            require("lspsaga").setup({
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
            })
            vim.keymap.set("n", "<leader>?", ":Lspsaga hover_doc<CR>", {
                desc = "Get inline documentation",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>k", ":Lspsaga term_toggle<CR>", {
                desc = "Toggle terminal",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>la", ":Lspsaga code_action<CR>", {
                desc = "Code action",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>lr", ":Lspsaga rename<CR>", {
                desc = "Rename token",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>lf", ":Lspsaga finder<CR>", {
                desc = "Find token refs",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>ld", ":Lspsaga show_line_diagnostics<CR>", {
                desc = "Line diagnostics",
                noremap = true,
                silent = true,
            })
            vim.keymap.set("n", "<leader>lj", ":Lspsaga goto_definition<CR>", {
                desc = "Jump to definition",
                noremap = true,
                silent = true,
            })

            require("which-key").register({
                ["<leader>"] = {
                    l = {
                        name = "+Saga",
                    },
                },
            })
        end,
    },
}
