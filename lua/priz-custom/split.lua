local keymaps = {
    ["<leader>s<Up>"] = {
        "Add split above",
        "<cmd>hor abo sp +bNext<CR>",
    },
    ["<leader>s<Down>"] = {
        "Add split below",
        "<cmd>hor bel sp +bNext<CR>",
    },
    ["<leader>s<Left>"] = {
        "Add split left",
        "<cmd>vert lefta sp +bNext<CR>",
    },
    ["<leader>s<Right>"] = {
        "Add split right",
        "<cmd>vert rightb sp +bNext<CR>",
    },

    ["<leader>k<Up>"] = {
        "Add term above",
        "<cmd>hor abo term<CR>i",
    },
    ["<leader>k<Down>"] = {
        "Add term below",
        "<cmd>hor bel term<CR>i",
    },
    ["<leader>k<Left>"] = {
        "Add term left",
        "<cmd>vert lefta term<CR>i",
    },
    ["<leader>k<Right>"] = {
        "Add term right",
        "<cmd>vert rightb term<CR>i",
    },
}

for k, v in pairs(keymaps) do
    vim.keymap.set("n", k, v[2], {
        desc = v[1],
        noremap = true,
        silent = true,
    })
end

return {}

