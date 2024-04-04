return {
    -- Code folding
    {
        "kevinhwang91/nvim-ufo",
        lazy = false,
        dependencies = {
            'kevinhwang91/promise-async',
        },
        config = function()
            vim.o.foldcolumn = "0"  -- No fold column; difficult to make out relative line numbers
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.foldenable = true

            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
            vim.keymap.set("n", "zq", "za", { desc = "Toggle fold" })   -- za is too close to be comfortable

            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return {'treesitter', 'indent'}
                end
            })
        end,
    },

    -- Also code folding
    {
        "nvim-treesitter/nvim-treesitter",
    },

    -- Show trailing whitespaces (deleted on save)
    {
        "johnfrankmorgan/whitespace.nvim",
        config = function ()
            require("whitespace-nvim").setup({
                highlight = "DiffDelete",
                ignored_filetypes = { "TelescopePrompt", "Trouble", "Help" },
            })
        end,
    },

    -- Icons and things
    {
        "ryanoasis/vim-devicons",
        name = "nvim-web-devicons",
        lazy = false,
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        lazy = false,
        config = function()
            local lualine = require("lualine")
            lualine.setup({
                options = {
                    theme = "catppuccin-frappe",
                    section_separators = { 
                        left = "", 
                        right = "" 
                    },
                    component_separators = { 
                        left = "", 
                        right = "" 
                    },
                    icons_enabled = true,
                },
                sections = {
                    lualine_a = { 
                        {
                            "mode",
                            icons_enabled = true,
                            icon = "",
                        }, 
                    },

                    lualine_y = {
                        function()
                            local lsp = vim.lsp.get_active_clients()[1].name or '<No LSP>'
                            return "󰚩 " .. lsp
                        end,
                    },

                    lualine_c = { 
                        {
                            "filetype",
                            icons_enabled = true,
                            icon_only = true,
                            colored = true,
                            icon = { align = "left" },
                            separator = "",
                        }, 
                        {
                            "filename",
                            separator = "",
                            padding = { left = 0, right = 1 },
                            symbols = {
                                modified = "~",
                                readonly = "",
                                unnamed = "_",
                                newfile = "+",
                            },
                        },
                    },

                    lualine_x = {
                        {
                            "diagnostics",
                            sources = { "nvim_lsp" },
                            sections = { "error", "warn", "info", "hint" },
                            color_error = "#BF616A",
                            color_warn = "#EBCB8B",
                            color_info = "#A3BE8C",
                            color_hint = "#88C0D0",
                            symbols = { error = " ", warn = " ", info = " ", hint = " " },
                        },
                    },

                    lualine_z = {
                        {
                            "%l/%L",
                            icons_enabled = true,
                            icon = '',
                            color = { gui = "bold" },
                            padding = { left = 1, right = 0 },
                        },
                        {
                            "%c",
                            color = { gui = "italic" },
                            padding = { left = 0, right = 1 },
                        },
                    },
                },
            })
        end,
    },


    -- Buffer tabs
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        config = function()
            require("bufferline").setup({
            })
        end,
    },

    -- File tree
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
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
                    vim.keymap.set("n", "<C-[>", api.tree.change_root_to_parent, opts("Up"))
                    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
                end,
            })
            vim.keymap.set("n", "<leader>n", api.tree.toggle, opts("Toggle"))

        end,
    },

    -- Scroll bar
    {
        "dstein64/nvim-scrollview",
        lazy = false,
    },

    -- Colorizer, eg #00ffff
    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

    -- Which key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                icons = {
                    separator = "~",
                },
            })
        end,
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },

    -- Indent bars
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end,
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
}
