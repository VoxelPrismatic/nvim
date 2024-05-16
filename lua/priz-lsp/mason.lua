local capabilities = vim.lsp.protocol.make_client_capabilities()

local _py_ignore = {
    "E251",     -- Unexpected spaces around keyword / parameter equals
    "W293",     -- Blank line contains whitespace
    "W391",     -- Blank line at end of file
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

return {
    {
        "williamboman/mason.nvim",
        name = "mason",
        build = ":MasonUpdate",
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
}
