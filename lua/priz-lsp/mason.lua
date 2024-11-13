local capabilities = vim.lsp.protocol.make_client_capabilities()

local _py_ignore = {
    "E251",     -- Unexpected spaces around keyword / parameter equals
    "W293",     -- Blank line contains whitespace
    "W391",     -- Blank line at end of file
}
local _linelen = 120

local servers = {
    pylsp = { pylsp = {
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
    }},

    lua_ls = { Lua = {
        diagnostics = {
            disable = {
                "trailing-space",
            },
        },
    }},

    ["harper_ls"] = { ["harper-ls"] = { linters = {
        sentence_capitalization = false,
        long_sentences = false,
        spelled_numbers = true,
    }}},
}

local required = {
    "gci",
    "goimports",
    "goimports-reviser",
    "golangci-lint",
    "golangci-lint-langserver",
    "golines",
    "gomodifytags",
    "gopls",
    "html-lsp",
    "templ",
    "htmx-lsp",
}

local running = true

function ToggleHarperLs()
    if not running then
        running = true
        vim.print("Starting Harper LS")
        require("lspconfig")["harper_ls"].setup({
            capabilities = capabilities,
            settings = servers["harper_ls"],
            flags = { debounce_text_changes = 300 },
        })
        return
    end

    for _, client in ipairs(vim.lsp.get_clients()) do
        if client.name == "harper_ls" then
            vim.print("Killing Harper LS")
            client.stop()
            if not pcall(vim.cmd, "edit") then
                vim.print("Save and run \\lh again to kill harper_ls")
                return
            end
            running = false
            return
        end
    end
end

vim.keymap.set("n", "<leader>lh", ToggleHarperLs, {
    desc = "Harper LS",
    noremap = true,
    silent = true
})

return { ---@type LazyPluginSpec[]
    {
        "williamboman/mason.nvim",
        name = "mason",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
            local registry = require("mason-registry")
            for _, v in ipairs(required) do
                local pkg = registry.get_package(v)
                if not pkg:is_installed() then
                    pkg:install()
                end
            end
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        name = "mason-lspconfig",
        dependencies = {{ "williamboman/mason.nvim", name = "mason" }},
        -- lazy = false,
        -- priority = 300,
        event = { "BufRead", "BufNewFile" },
        config = true,
        opts = {
            ensure_installed = vim.tbl_keys(servers),
            automatic_installation = true,
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        settings = servers[server_name],
                        flags = { debounce_text_changes = 300 },
                    })
                end
            },
        },
    },
}
