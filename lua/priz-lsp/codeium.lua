return { ---@type LazyPluginSpec
    "Exafunction/codeium.vim",
    lazy = false,
    cmd = {
        "CodeiumEnable",
        "CodeiumDisable",
        "CodeiumToggle",
    },
    keys = {
        "<S-Tab>", "<cmd>CodeiumToggle<CR> <Backspace>",
        mode = "i",
        desc = "Toggle codeium",
    },
}
