---@diagnostic disable-next-line: undefined-global
local vim = vim

local indicators = {
    error = "",
    warning = "",
    info = "",
    hint = "",
}

return {
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        event = { "BufReadPre", "BufEnter" },
        config = function()
            local lualine = require("lualine")

            lualine.setup({
                options = {
                    theme = "rose-pine-moon",
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
                            local lsp = vim.lsp.get_active_clients()[1].name or "<No LSP>"
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
                            icon = "",
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
        event = { "BufReadPre", "BufEnter" },
        config = function()
            require("bufferline").setup({
                options = {
                    right_mouse_command = nil,
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, _, _)
                        return " " .. count .. indicators[level]
                    end,
                },
            })
        end,
    },

    -- Scroll bar
    {
        "dstein64/nvim-scrollview",
        event = { "BufReadPre", "BufEnter" },
    },

}
