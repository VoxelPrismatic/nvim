# nvim
My custom neovim flavor

# warning
as of may 02 2024, you will get an error when using this config. rose-pine has not merged my pr
to support a different color for lualine. you can fix it in `lua/priz-lazy/colors.lua`

# install
```sh
rm -rdf ~/.config/nvim
rm -rdf ~/.local/share/nvim
git clone https://github.com/VoxelPrismatic/nvim ~/.config/nvim
```

# update
```
cd ~/.config/nvim
git reset --hard
git pull
```

## keys
`<leader>` = `\\`
|        combo        |   mode   |                 action                 |      location      |    package    |
|---------------------|----------|----------------------------------------|--------------------|---------------|
| `<leader>u`         | n        | launch undo tree                       | `init.lua`         | undotree      |
| `<leader>/`         | n, v     | comment line                           | `init.lua`         | comment.nvim  |
| `<leader>]`         | n, v     | comment block                          | `init.lua`         | comment.nvim  |
| `<leader>b`         | n        | new buffer                             | `keys.lua`         | [nil]         |
| `<leader>c`         | n        | close buffer                           | `keys.lua`         | [nil]         |
| `<leader>\`         | n        | clear highlights                       | `keys.lua`         | [nil]         |
| `<Home>`            | n, i     | start of line or start of code         | `keys.lua`         | [nil]         |
| `<M-k>`             | n, v     | move lines up                          | `keys.lua`         | moveline.nvim |
| `<M-j>`             | n, v     | move lines down                        | `keys.lua`         | moveline.nvim |
| `<F1>`-`<F12>`      | n, i     | [unset]                                | `keys.lua`         | [nil]         |
| `<C-d>`             | i        | scroll autocomplete down               | `lsp.lua`          | nvim-cmp      |
| `<C-f>`             | i        | scroll autocomplete up                 | `lsp.lua`          | nvim-cmp      |
| `<C-space>`         | i        | autocomplete                           | `lsp.lua`          | nvim-cmp      |
| `<F1>`              | i        | confirm autocomplete                   | `lsp.lua`          | nvim-cmp      |
| `<F2>`              | i        | next autocomplete                      | `lsp.lua`          | nvim-cmp      |
| `<F3>`              | i        | escape autocomplete                    | `lsp.lua`          | nvim-cmp      |
| `<leader>?`         | n        | hover docs                             | `lsp.lua`          | lspsaga       |
| `<leader>k`         | n        | hover konsole                          | `lsp.lua`          | lspsaga       |
| `<leader>la`        | n        | code action                            | `lsp.lua`          | lspsaga       |
| `<leader>lr`        | n        | rename token                           | `lsp.lua`          | lspsaga       |
| `<leader>lf`        | n        | find token references                  | `lsp.lua`          | lspsaga       |
| `<leader>ld`        | n        | diagnostics                            | `lsp.lua`          | lspsaga       |
| `<leader>lj`        | n        | jump to definition                     | `lsp.lua`          | lspsaga       |
| `<leader>s<Up>`     | n        | add split above                        | `split-keys.lua`   | [nil]         |
| `<leader>s<Down>`   | n        | add split below                        | `split-keys.lua`   | [nil]         |
| `<leader>s<Left>`   | n        | add split left                         | `split-keys.lua`   | [nil]         |
| `<leader>s<Right>`  | n        | add split right                        | `split-keys.lua`   | [nil]         |
| `<leader>tf`        | n        | telescope find files                   | `telescope.lua`    | telescope     |
| `<leader>tg`        | n        | telescope live grep                    | `telescope.lua`    | telescope     |
| `<leader>tb`        | n        | telescope buffers                      | `telescope.lua`    | telescope     |
| `<leader>tt`        | n        | launch telescope                       | `telescope.lua`    | telescope     |
| `<leader>n`         | n        | toggle oil                             | `tree.lua`         | oil.nvim      |
| `zR`                | n        | open all folds                         | `tree.lua`         | nvim ufo      |
| `zM`                | n        | close all folds                        | `tree.lua`         | nvim ufo      |
| `zq`                | n        | toggle this fold                       | `tree.lua`         | nvim ufo      |


## Packages
- colors
  - [rose-pine](https://github.com/rose-pine/neovim)
- init
  - [codeium](https://github.com/Exafunction/codeium.vim)
  - [vim be good](https://github.com/theprimeagen/vim-be-good)
  - [comments](https://github.com/numToStr/Comment.nvim)
  - [undotree](https://github.com/mbbill/undotree)
- keys
  - [moveline](https://github.com/willothy/moveline.nvim)
- lsp
  - [lspconfig](https://github.com/neovim/nvim-lspconfig)
  - [cmp](https://github.com/hrsh7th/nvim-cmp)
  - [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
  - [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
  - [cmp-path](https://github.com/hrsh7th/cmp-path)
  - [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
  - [mason](https://github.com/williamboman/mason.nvim)
  - [mason-lspconfig](https://github.com/williamboman/mason-lspconfig)
  - [conform](https://github.com/stevearc/conform.nvim)
  - [lspsaga](https://github.com/nvimdev/lspsaga.nvim)
- telescope
  - [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
  - [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- tree
  - [oil](https://github.com/stevearc/oil.nvim)
  - [gitsigns](https://github.com/lewis6991/gitsigns.nvim)
- ui
  - [ufo](https://github.com/kevinhwang91/nvim-ufo)
  - [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  - [devicons](https://github.com/ryanoasis/vim-devicons)
  - [colorizer](https://github.com/NvChad/nvim-colorizer.lua)
  - [which key](https://github.com/folke/which-key.nvim)
  - [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- view
  - [lualine](https://github.com/nvim-lualine/lualine.nvim)
  - [bufferline](https://github.com/akinsho/bufferline.nvim)
  - [scrollview](https://github.com/dstein64/nvim-scrollview)

## Settings
- enable relative line numbers
- enable mouse support
- ignorecase & smartcase searching
- no line wrap
- set tab width to 4 spaces
- highlight current line
- display trailing spaces as `·`
- display tabs as `>——— `
- clear trailing spaces on save
- use system clipboard
- py lint ignore E251, W293, W391
- disable background (enable transparency)


### screenshot
![Screenshot_2024-05-02_02:11:18](https://github.com/VoxelPrismatic/nvim/assets/45671764/bf909310-c70c-4e56-a66d-8825a1e78875)
![Screenshot_2024-05-02_02:12:30](https://github.com/VoxelPrismatic/nvim/assets/45671764/bbd6f752-70e9-49a3-9386-f0dbbd36efe4)


### my personal fav feature
the quality of life enhancement over this little home key remapping cannot be truly described
<video src="https://github.com/VoxelPrismatic/nvim/assets/45671764/7a20dd54-e125-4ace-afd5-7aa66992c705"></video>

### side note
this uses the system clipboard. it is recommended that you have an extra tool to help you retrieve previous clips.
since i use KDE, this is built in.
