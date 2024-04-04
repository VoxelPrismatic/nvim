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
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Esc>"] = cmp.mapping.close(),
                    ["<C-s>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "cmdline" },
                    { name = "vsnip" },
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        name = "mason",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        name = "mason-lspconfig",
        lazy = false,
        config = function()
            local lsp = require("mason-lspconfig")
            lsp.setup({
                ensure_installed = { "pylsp" },
                automatic_installation = true,
            })
            lsp.setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        settings = servers[server_name],
                    })
                end,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
    },
}
