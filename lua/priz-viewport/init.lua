local bg_timer = vim.uv.new_timer()

local function toggle_background(set, timer)
    local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
    if set == false or (set == nil and hl.bg ~= nil) then
        vim.print("")
        bg_timer:stop()
        return vim.cmd("hi Normal guibg=none")
    end

    local rosepine = require("rose-pine.palette")
    -- Konsole detects the same background color, so we add one. Shouldn't be too noticeable.
    hl.bg = tonumber(rosepine.base:sub(2), 16) + 1
    vim.api.nvim_set_hl(0, "Normal", hl)

    if set == nil then
        -- vim.print("Screenshot mode enabled")
        bg_timer:start(timer or 2000, 0, vim.schedule_wrap(toggle_background))
    else
        vim.print("Screen recording...")
    end
end

return { ---@type LazyPluginSpec
    "voxelprismatic/rosepine-neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    opts = { ---@type RosePine.Options
        swatch = "sakura",
        highlight_groups = {
            IndentLine = { fg = "highlight_high" },
            IndentLineCurrent = { fg = "iris" },

            RosePineFgBase = { fg = "base" },
            RosePineFgSurface = { fg = "surface" },
            RosePineFgHlLow = { fg = "highlight_low" },
            RosePineFgHlMid = { fg = "highlight_med" },
            RosePineFgHlHigh = { fg = "highlight_high" },
            RosePineFgMuted = { fg = "muted" },
            RosePineFgSubtle = { fg = "subtle" },
            RosePineFgText = { fg = "text" },
            RosePineFgLove = { fg = "love" },
            RosePineFgGold = { fg = "gold" },
            RosePineFgRose = { fg = "rose" },
            RosePineFgPine = { fg = "pine" },
            RosePineFgFoam = { fg = "foam" },
            RosePineFgIris = { fg = "iris" },
            RosePineFgTree = { fg = "tree" },

            Whitespace = { fg = "highlight_med" },
        },
    },
    keys = {
        {
            "<leader>p", toggle_background,
            mode = "n",
            desc = "Toggle background"
        },
        {
            "<leader>P", function() toggle_background(true) end,
            mode = "n",
            desc = "Enable background"
        },
    },
    config = function(_, opts)
        require("rose-pine").setup(opts)
        vim.cmd("colorscheme rose-pine-dawn")
        toggle_background()
        toggle_background(nil, 250)
    end
}


