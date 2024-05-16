local icons = {
    indicators = {
        error = "",
        warn = "󰔶",
        warning = "󰔶",
        info = "",
        hint = "󱐋",
    },

    modifiers = {
        modified = "󱐋",
        readonly = "",
        unnamed = "",
        newfile = "",
    }
}

icons.mod_arr = {
    icons.modifiers.modified,
    icons.modifiers.readonly,
    icons.modifiers.newfile
}

local function lua_filename(fn, _)
    local mod = ""
    for _, v in ipairs(icons.mod_arr) do
        if fn:sub(-#v) == v then
            mod = fn:sub(-(#v + 1))
            fn = fn:sub(1, -(#v + 2))
            break
        end
    end

    if fn == "[No Name]" then fn = "" end

    if fn:len() > 0 then
        return fn .. mod
    elseif vim.bo.filetype:len() > 0 then
        return vim.bo.filetype .. mod
    end
    return " #nil" .. mod
end

local line_seps = {
    left = "",
    right = "",
    circle = "",
    line = "",
}

local other_icons = {
    vim = "",
    bot = "󰚩",
    line = "",
}

local function spread(template)
    local result = {}
    for key, value in pairs(template) do
        result[key] = value
    end

    return function(table)
        for key, value in pairs(table) do
            result[key] = value
        end
        return result
    end
end

return {
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        config = function()
            require("bufferline").setup({
                options = {
                    right_mouse_command = nil,
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, _, _)
                        return icons.indicators[level] .. count
                    end,
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        event = "VeryLazy",
        config = function()
            local rose_pine = require("rose-pine.palette").variants.dawn
            local inactive = {{
                "filename",
                draw_empty = true,
                color = { fg = rose_pine.highlight_high, bg = rose_pine.highlight_high },
                padding = { left = 128, right = 128 },
            }}

            local inactive_color = { fg = rose_pine.surface, bg = rose_pine.gold, gui = "bold" }

            local diagnostic_line = {
                "diagnostics",
                sources = { "nvim_lsp" },
                sections = { "error", "warn", "info", "hint" },
                color_error = rose_pine.love,
                color_warn = rose_pine.gold,
                color_info = rose_pine.iris,
                color_hint = rose_pine.muted,
                symbols = icons.indicators,
            }

            local file_line = {
                {
                    "filetype",
                    icons_enabled = true,
                    icon_only = true,
                    colored = true,
                    icon = { align = "left" },
                    separator = "",
                    padding = { left = 1, right = 0 },
                },
                {
                    "filename",
                    separator = "",
                    padding = { left = 0, right = 1 },
                    symbols = icons.modifiers,
                    fmt = lua_filename,
                }
            }


            require("lualine").setup({
                options = {
                    theme = "rose-pine-neutral",
                    section_separators = { left = line_seps.left, right = line_seps.right },
                    component_separators = { left = line_seps.line, right = line_seps.line },
                    icons_enabled = true,
                },
                inactive_sections = {
                    lualine_a = {
                        spread(file_line[1]) {
                            color = inactive_color,
                            colored = false
                        },
                        spread(file_line[2]) {
                            color = inactive_color,
                            separator = { right = line_seps.circle },
                        },
                    },
                    lualine_b = { spread(diagnostic_line) {
                        color = { bg = rose_pine.highlight_med },
                        separator = { right = line_seps.circle },
                    }},
                    lualine_c = inactive,
                    lualine_x = inactive,
                    lualine_y = inactive,
                    lualine_z = inactive,
                },
                sections = {
                    lualine_a = {{
                        "mode",
                        icons_enabled = true,
                        icon = other_icons.vim,
                    }},

                    lualine_y = {
                        function()
                            return other_icons.bot .. " " .. (vim.lsp.get_active_clients()[1].name or "<No LSP>")
                        end,
                    },

                    lualine_b = {
                        { "branch" },
                        {
                            "diff",
                            diff_color = {
                                added = { fg = rose_pine.iris },
                                modified = { fg = rose_pine.gold },
                                removed = { fg = rose_pine.rose },
                            },
                            symbols = { removed = "–" },
                        },
                    },

                    lualine_c = file_line,

                    lualine_x = { diagnostic_line },

                    lualine_z = {
                        {
                            "%l/%L",
                            icons_enabled = true,
                            icon = other_icons.line,
                            color = { gui = "bold" },
                            padding = { left = 1, right = 0 },
                        }, {
                            "%c",
                            color = { gui = "italic" },
                            padding = { left = 0, right = 1 },
                        }
                    },
                },
            })
        end,
    }
}
