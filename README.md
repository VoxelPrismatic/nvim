# nvim

My custom neovim flavor

### Install

```sh
rm -rdf ~/.config/nvim
rm -rdf ~/.local/share/nvim
git clone https://github.com/VoxelPrismatic/nvim ~/.config/nvim
```

make sure you also have the following packages installed:

- `clang`
- `fzf`
- `ripgrep`

### Update

```
cd ~/.config/nvim
git reset --hard
git pull
```

# Details

### Theme

**Main:** Rose Pine Dawn (my fork)
**Lualine:** Neutral, with mods to the inactive bar
**Bufferline:** Default

### Custom keys & motions

`<leader>` = `\\`
| Plugin | Location | Mode | Motion | Action |
| - | - | - | - | - |
| \[custom\] | `custom/home.lua` | `n i v` | `<Home>` | Start of line or start of code |
| \[custom\] | `custom/init.lua` | `n    ` | `<leader>b` | New buffer |
| \[custom\] | `custom/init.lua` | `n    ` | `<leader>c` | Close buffer |
| \[custom\] | `custom/init.lua` | `n    ` | `<leader>\\` | Clear highlights |
| \[custom\] | `custom/init.lua` | `  i  ` | `<C-e>` | Delete next word (like ctrl+del) |
| \[custom\] | `custom/init.lua` | `n i  ` | `<F1>` - `<F12>` | \[unset\] |
| \[custom\] | `custom/split.lua` | `n    ` | `<leader>s<Up>` | Add split above |
| \[custom\] | `custom/split.lua` | `n    ` | `<leader>s<Down>` | Add split below |
| \[custom\] | `custom/split.lua` | `n    ` | `<leader>s<Left>` | Add split left |
| \[custom\] | `custom/split.lua` | `n    ` | `<leader>s<Right>` | Add split right |
| [numToStr/Comment.nvim][nscm] | `interact/comment.lua` | `n   v` | `<leader>/` | Comment line |
| [numToStr/Comment.nvim][nscm] | `interact/comment.lua` | `n   v` | `<leader>]` | Comment block |
| [kevinhwang91/nvim-ufo][nufo] | `interact/folding.lua` | `n    ` | `zR` | Open all folds |
| [kevinhwang91/nvim-ufo][nufo] | `interact/folding.lua` | `n    ` | `zM` | Close all folds |
| [kevinhwang91/nvim-ufo][nufo] | `interact/folding.lua` | `n    ` | `zq` | Toggle this fold |
| [willothy/moveline.nvim][mvln] | `interact/moveline.lua` | `n i v` | `<M-k>` | Move lines up |
| [willothy/moveline.nvim][mvln] | `interact/moveline.lua` | `n i v` | `<M-j>` | Move lines down |
| [voxelprismatic/rabbit.nvim][zrbt] | `interact/rabbit.lua` | `n    ` | `<leader>r` | Launch Rabbit |
| [telescope.nvim][tele] | `interact/telescope.lua` | `n    ` | `<leader>tf` | Find files |
| [telescope.nvim][tele] | `interact/telescope.lua` | `n    ` | `<leader>tg` | Live grep |
| [telescope.nvim][tele] | `interact/telescope.lua` | `n    ` | `<leader>tb` | Buffers (but rabbit is better) |
| [telescope.nvim][tele] | `interact/telescope.lua` | `n    ` | `<leader>tt` | Launch telescope |
| [hrsh7th/nvim-cmp][hcmp] | `lsp/init.lua` | `  i  ` | `<C-d>` | Scroll docs down |
| [hrsh7th/nvim-cmp][hcmp] | `lsp/init.lua` | `  i  ` | `<C-f>` | Scroll docs up |
| [hrsh7th/nvim-cmp][hcmp] | `lsp/init.lua` | `  i  ` | `<C-space>` | Show completion menu |
| [hrsh7th/nvim-cmp][hcmp] | `lsp/init.lua` | `  i  ` | `<F1>` | Confirm completion choice |
| [hrsh7th/nvim-cmp][hcmp] | `lsp/init.lua` | `  i  ` | `<F2>` | Next completion choice |
| [hrsh7th/nvim-cmp][hcmp] | `lsp/init.lua` | `  i  ` | `<F3>` | Close completion menu |
| [hrsh7th/nvim-cmp][hcmp] | `lsp/init.lua` | `  i  ` | `<F4>` | Prev completion choice |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>?` | Show LSP documentation |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>k` | Toggle terminal (konsole) |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>lr` | Rename variable |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>la` | Show LSP code actions |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>lf` | Find all token references |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>ld` | Show LSP diagnostics |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>lo` | Show file outline |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>lj` | Jump to declaration |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>lt` | Jump to struct |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>lsj` | Peek declaration |
| [nvimdev/lspsaga.nvim][saga] | `lsp/lspsaga.lua` | `n    ` | `<leader>lst` | Peek struct |
| [stevearc/oil.nvim][soil] | `viewport/oil.lua` | `n    ` | `<leader>o` | Open file tree |

### Other plugins

| Plugin                             | Location                  | Purpose                         |
| ---------------------------------- | ------------------------- | ------------------------------- |
| [NvChad/nvim-colorizer.lua][nclr]  | `interact/colorizer.lua`  | Highlight color codes           |
| [nvim-treesitter][tree]            | `interact/folding.lua`    | Fold code blocks                |
| [nvimdev/indentmini.nvim][idnt]    | `interact/indentbars.lua` | Show indent lines               |
| [ThePrimeagen/vim-be-good][skil]   | `interact/init.lua`       | I still use arrow keys          |
| [telescope; fzf-native.nvim][tfzf] | `interact/telescope.lua`  | Fuzzy search                    |
| [folke/which-key.nvim][wkey]       | `interact/whichkey.lua`   | Show keybindings                |
| [exafunction/codeium.vim][cplt]    | `lsp/codeium.lua`         | Like Copilot, but free          |
| [neovim/nvim-lspconfig][nlsp]      | `lsp/init.lua`            | LSP support for neovim          |
| [williamboman/mason.nvim][wmsn]    | `lsp/mason.lua`           | Because LSPs are based          |
| [lewis6991/gitsigns.nvim][gits]    | `viewport/giticons.lua`   | Show git diff in line no column |
| [ryanosis/vim-devicons][vicn]      | `viewport/icons.lua`      | Devicons for nvim               |
| [rosepine-neovim][rose]            | `viewport/init.lua`       | My favorite theme               |
| [dstein64/nvim-scrollview][scrl]   | `viewport/scrollview.lua` | Scrollbar                       |
| [akinsho/bufferline.nvim][bbuf]    | `viewport/tabline.lua`    | Show tabs and buffers           |
| [nvim-lualine/lualine.nvim][lual]  | `viewport/lualine.lua`    | Lualine                         |

[nscm]: https://github.com/numToStr/Comment.nvim
[nufo]: https://github.com/kevinhwang91/nvim-ufo
[mvln]: https://github.com/willothy/moveline.nvim
[zrbt]: https://github.com/voxelprismatic/rabbit.nvim
[tele]: https://github.com/nvim-telescope/telescope.nvim
[hcmp]: https://github.com/hrsh7th/nvim-cmp
[saga]: https://github.com/glepnir/lspsaga.nvim
[nclr]: https://github.com/NvChad/nvim-colorizer.lua
[tree]: https://github.com/nvim-treesitter/nvim-treesitter
[idnt]: https://github.com/nvimdev/indentmini.nvim
[skil]: https://github.com/ThePrimeagen/vim-be-good
[tfzf]: https://github.com/nvim-telescope/telescope-fzf-native.nvim
[wkey]: https://github.com/folke/which-key.nvim
[cplt]: https://github.com/exafunction/codeium.vim
[nlsp]: https://github.com/neovim/nvim-lspconfig
[wmsn]: https://github.com/williamboman/mason.nvim
[gits]: https://github.com/lewis6991/gitsigns.nvim
[vicn]: https://github.com/ryanoasis/vim-devicons
[rose]: https://github.com/voxelprismatic/rosepine-neovim
[bbuf]: https://github.com/akinsho/bufferline.nvim
[lual]: https://github.com/nvim-lualine/lualine.nvim
[scrl]: https://github.com/nvim-scrollview/nvim-scrollview
[soil]: https://github.com/steveaxton/oil.nvim

### Settings

- Enable relative line numbers
- Enable mouse support
- Ignorecase & smartcase searching
- Disable line wrap
- Indent tab = four spaces `    `
- Real tab = `>——— `
- Trailing spaces = `·`
  - All trailing spaces are removed upon save
- Highlight current line
- Use system clipboard
- Disable background (enable transparency)

### LSP Configs

- Pylsp
  - `pylsp`
    - `jedi_completion`
      - fuzzy = true
      - eager = true
      - include class objects = true
      - include function objects = true
    - `flake8`, `pycodestyle`
      - max line length = 120
      - ignore =
        - `E251` - Unexpected spaces around keyword / parameter equals
        - `W293` - Blank line contains whitespace (as this is deleted upon save)
        - `W391` - Blank line at end of file
- lua ls
  - `Lua`
    - `diagnostics`
      - `disable`
        - Trailing whitespace
- harper ls
  - `harper_ls`
    - `linters`
      - Sentence capitalization = false (keeps screaming on URLs)
      - Long sentences = false (luadoc moment)
      - Spelled numbers = true

### Screenshot

![Screenshot_20240517_203623](https://github.com/VoxelPrismatic/nvim/assets/45671764/636d254b-34c1-4415-ab21-5f7f15109027)
![Screenshot_20240517_203909](https://github.com/VoxelPrismatic/nvim/assets/45671764/f9df0df4-3701-46c9-a9b4-4d88fabfbe98)
