-- Hide LSP warnings
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
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
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
        name = "mason",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
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
    },
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            require("lspsaga").setup({
                code_action_prompt = {
                    enable = false,
                },
                code_action_keys = {
                    quit = "<Esc>",
                    exec = "<CR>",
                },
            })
            vim.keymap.set("n", "<leader>?", "<cmd>Lspsaga hover_doc<CR>", {
                desc = "Get inline documentation",
                noremap = true,
                silent = true,
            })
        end,
    },
}
