return { ---@type LazyPluginSpec
    "NvChad/nvim-colorizer.lua",
    main = "colorizer",
    lazy = false,
    config = true,
    opts = { ---@type ColorizerOpts
        filetypes = { "*" },
        user_default_options = {
            RGB = true,
            RRGGBB = true,
            names = false,
            mode = "background",
            rgb_fn = true,
            hsl_fn = true,
        }
    },
}


---@class ColorizerOpts
---@field filetypes? ColorizerStringOrOpts[]
---@field buftypes? ColorizerStringOrOpts[] All the sub-options of filetypes apply to buftypes
---@field user_default_options? ColorizerTypeOpts


---@class ColorizerTypeOpts
---@field RGB? boolean #RGB hex codes
---@field RRGGBB? boolean #RRGGBB hex codes
---@field names? boolean "Name" codes like Blue or blue
---@field RRGGBBAA? boolean #RRGGBBAA hex codes
---@field AARRGGBB? boolean 0xAARRGGBB hex codes
---@field rgb_fn? boolean CSS rgb() and rgba() functions
---@field hsl_fn? boolean CSS hsl() and hsla() functions
---@field css? boolean Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
---@field css_fn? boolean Enable all CSS *functions*: rgb_fn, hsl_fn
---@field mode? "virtualtext" | "foreground" | "background" Set display mode
---@field tailwind? boolean | "normal" | "lsp" | "both" Enable tailwind colors; true=normal
---@field sass? ColorizerSassOpts Enable sass colors
---@field virtualtext? string The character used if mode=virtualtext
---@field always_update? boolean Update color values even if buffer is not focused; eg cmp_menu or cmp_docs


---@class ColorizerSassOpts
---@field enable boolean
---@field parsers string[]


---@alias ColorizerStringOrOpts string | ColorizerTypeOpts
