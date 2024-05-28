---@diagnostic disable-next-line: undefined-global
local vim = vim

return {
    {
        "voxelprismatic/rosepine-neovim",
        name = "rose-pine",
        priority = 1000,
        lazy = false,
        config = function()
            require("rose-pine").setup({
                highlight_groups = {
                    IndentLine = { fg = "highlight_high" },
                    IndentLineCurrent = { fg = "iris" },

                    RosePineFgBase = { fg = "base" },
                    RosePineFgSurface = { fg = "surface" },
                    RosePineFgHighlight = { fg = "highlight" },
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
                },
            })
            vim.cmd.colorscheme("rose-pine-dawn")
        end,
    },
}

