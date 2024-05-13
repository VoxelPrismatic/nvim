---@diagnostic disable-next-line: undefined-global
local vim = vim

local indicators = {
    error = "",
    warn = "󰔶",
    warning = "󰔶",
    info = "",
    hint = "󱐋",
}

local modifiers = {
    modified = "󱐋",
    readonly = "",
    unnamed = "",
    newfile = "",
}

local mod_arr = { modifiers.modified, modifiers.readonly, modifiers.newfile }

LualineContext = {}

local function lua_filename(fn, ctx)
    LualineContext = ctx

    local mod = ""
    for _, v in ipairs(mod_arr) do
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

return {
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        event = { "BufReadPre", "BufEnter" },
        config = function()
            local rose_pine = require("rose-pine.palette")
            local inactive = {{
                "filename",
                draw_empty = true,
                color = { fg = rose_pine.highlight_high, bg = rose_pine.highlight_high },
                padding = { left = 48, right = 48 },
            }}
            require("lualine").setup({
                options = {
                    theme = "rose-pine-neutral",
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                    icons_enabled = true,
                },
                inactive_sections = {
                    lualine_a = {{
                        "filetype",
                        icons_enabled = true,
                        icon_only = true,
                        colored = true,
                        icon = { align = "left" },
                        separator = "",
                        padding = { left = 1, right = 0 },
                        color = { fg = rose_pine.surface, bg = rose_pine.gold, gui = "bold" },
                    }, {
                        "filename",
                        padding = { left = 0, right = 1 },
                        color = { fg = rose_pine.surface, bg = rose_pine.gold, gui = "bold" },
                        separator = { right = "" },
                        fmt = lua_filename,
                        symbols = modifiers,
                    }},
                    lualine_b = {{
                        "diagnostics",
                        sources = { "nvim_lsp" },
                        sections = { "error", "warn", "info", "hint" },
                        color_error = rose_pine.love,
                        color_warn = rose_pine.gold,
                        color_info = rose_pine.iris,
                        color_hint = rose_pine.muted,
                        symbols = indicators,
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
                        icon = "",
                    }},

                    lualine_y = {
                        function()
                            return "󰚩 " .. (vim.lsp.get_active_clients()[1].name or "<No LSP>")
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

                    lualine_c = {{
                        "filetype",
                        icons_enabled = true,
                        icon_only = true,
                        colored = true,
                        icon = { align = "left" },
                        separator = "",
                        padding = { left = 1, right = 0 },
                    }, {
                        "filename",
                        separator = "",
                        padding = { left = 0, right = 1 },
                        symbols = modifiers,
                        fmt = lua_filename,
                    }},

                    lualine_x = {{
                        "diagnostics",
                        sources = { "nvim_lsp" },
                        sections = { "error", "warn", "info", "hint" },
                        color_error = rose_pine.love,
                        color_warn = rose_pine.gold,
                        color_info = rose_pine.iris,
                        color_hint = rose_pine.muted,
                        symbols = indicators,
                    }},

                    lualine_z = {{
                        "%l/%L",
                        icons_enabled = true,
                        icon = "",
                        color = { gui = "bold" },
                        padding = { left = 1, right = 0 },
                    }, {
                        "%c",
                        color = { gui = "italic" },
                        padding = { left = 0, right = 1 },
                    }},
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
                        return indicators[level] .. count
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
