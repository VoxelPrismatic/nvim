# nvim
My custom neovim flavor

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

# keys
`<leader>` = `\\`
| combo | mode | action | specified in document |
|-------|------|--------|-----------------------|
| `<leader>b` | n | New buffer | `lua/keys.lua` |
| `<leader>c` | n | Close buffer | `lua/keys.lua` |
| `<leader>\\` | n | Clear highlights | `lua/keys.lua` |
| `<leader>r` | n | Restart Copilot | `lua/keys.lua` |
| `<F1>`-`<F12>` | n | \<Nop\> | `lua/keys.lua` |
| `<Home>` | n, i | Toggles between start of line and first non-whitespace character | `lua/keys.lua` |
| `<M-k>` | n, v | Move lines up | `lua/keys.lua` |
| `<M-j>` | n, v | Move lines down | `lua/keys.lua` |
| `<leader>t` | n | Telescope find files | `lua/init.lua` |
| `<leader>/` | n, v | Comment line | `lua/init.lua` |
| `<leader>]` | n, v | Comment block | `lua/init.lua` |
| `<leader>u` | n | Undo tree | `lua/init.lua` |
| `zR` | n | Unfold all | `lua/ui.lua` |
| `zM` | n | Fold all | `lua/ui.lua` |
| `zq` | n | Toggle current fold | `lua/ui.lua` |
| `<C-BS>` | NvimTree: n | Up folder | `lua/ui.lua` |
| `?` | NvimTree: n | Help | `lua/ui.lua` |
| `<leader>n` | n | Toggle NvimTree | `lua/ui.lua` |
| `<leader>?` | n | Toggle Lspsaga HoverDoc | `lua/lsp.lua` |



### Includes
<details>
    <summary>Packages</summary>
    <ul>
        <li><a href="https://github.com/kevinhwang91/nvim-ufo">kevinhwang91/nvim-ufo</a></li>
        <li><a href="https://github.com/nvim-treesitter/nvim-treesitter">nvim-treesitter/nvim-treesitter</a></li>
        <li><a href="https://github.com/ryanosis/vim-devicons">ryanosis/vim-devicons</a></li>
        <li><a href="https://github.com/nvim-lualine/lualine.nvim">nvim-lualine/lualine.nvim</a></li>
        <li><a href="https://github.com/akinsho/bufferline.nvim">akinsho/bufferline.nvim</a></li>
        <li><a href="https://github.com/nvim-tree/nvim-tree.lua">nvim-tree/nvim-tree.lua</a></li>
        <li><a href="https://github.com/dstein64/nvim-scrollview">dstein64/nvim-scrollview</a></li>
        <li><a href="https://github.com/NvChad/nvim-colorizer.lua">NvChad/nvim-colorizer.lua</a></li>
        <li><a href="https://github.com/folke/which-key.nvim">folke/which-key.nvim</a></li>
        <li><a href="https://github.com/lukas-reineke/indent-blankline.nvim">lukas-reineke/indent-blankline.nvim</a></li>
        <li><a href="https://github.com/lewis6991/gitsigns.nvim">lewis6991/gitsigns.nvim</a></li>
        <li><a href="https://github.com/catppuccino/nvim">catppuccin/nvim</a> - Latte</li>
        <li><a href="https://github.com/github/copilot">github/copilot</a></li>
        <li><a href="https://github.com/nvim-telescope/telescope.nvim">nvim-telescope/telescope.nvim</a></li>
        <li><a href="https://github.com/nvim-telescope/telescope-fzf-native.nvim">nvim-telescope/telescope-fzf-native.nvim</a></li>
        <li><a href="https://github.com/numToStr/Comment.nvim">numToStr/Comment.nvim</a></li>
        <li><a href="https://github.com/mbbill/undotree">mbbill/undotree</a></li>
        <li><a href="https://github.com/willothy/moveline.nvim">willothy/moveline.nvim</a></li>
    </ul>
    <details>
        <summary>LSP</summary>
        <ul>
            <li><a href="https://github.com/neovim/nvim-lspconfig">neovim/nvim-lspconfig</a></li>
            <li><a href="https://github.com/hrsh7th/cmp-nvim-lsp">hrsh7th/cmp-nvim-lsp</a></li>
            <li><a href="https://github.com/hrsh7th/cmp-buffer">hrsh7th/cmp-buffer</a></li>
            <li><a href="https://github.com/hrsh7th/cmp-path">hrsh7th/cmp-path</a></li>
            <li><a href="https://github.com/hrsh7th/cmp-cmdline">hrsh7th/cmp-cmdline</a></li>
            <li><a href="https://github.com/hrsh7th/cmp-vsnip">hrsh7th/cmp-vsnip</a></li>
            <li><a href="https://github.com/hrsh7th/vim-vsnip">hrsh7th/vim-vsnip</a></li>
            <li><a href="https://github.com/hrsh7th/nvim-cmp">hrsh7th/nvim-cmp</a></li>
            <li><a href="https://github.com/williamboman/mason.nvim">williamboman/mason.nvim</a></li>
            <li><a href="https://github.com/williamboman/mason-lspconfig">williamboman/mason-lspconfig</a></li>
            <li><a href="https://github.com/stevearc/conform.nvim">stevearc/conform.nvim</a></li>
            <li><a href="https://github.com/nvimdev/lspsaga.nvim">nvimdev/lspsaga.nvim</a></li>
        </ul>
    </details>
</details>
<details>
    <summary>Mods & Settings</summary>
    <ol>
        <li>Show relative line numbers</li>
        <li>Enable mouse support</li>
        <li>Ignorecase & Smartcase searching</li>
        <li>
            Line wrapping
            <ul>
                <li>Wrap at word boundaries</li>
                <li>Keep indent</li>
                <li>Indicator = <code>~~~&gt;  </code></li>
            </ul>
        </li>
        <li>Set tab width to 4 spaces</li>
        <li>Highlight current line</li>
        <li>Display trailing spaces as <code>·</code></li>
        <li>Clear trailing spaces on save</li>
        <li>Use system clipboard</li>
        <li>Python LSP ignores <code>E251</code>, <code>W293</code>, <code>W391</code></li>
    </ol>
</details>

### screenshot
!<a href="https://github.com/VoxelPrismatic/nvim/assets/45671764/be3fe13b-02bf-472a-b40a-579bf12b0fa8">image</a>
!<a href="https://github.com/VoxelPrismatic/nvim/assets/45671764/b0f28830-eef1-4960-afae-1fc32d92166e">image</a>

### my personal fav feature
the quality of life enhancement over this little home key remapping cannot be truly described
<video src="https://github.com/VoxelPrismatic/nvim/assets/45671764/7a20dd54-e125-4ace-afd5-7aa66992c705"></video>

### side note
this uses the system clipboard. it is recommended that you have an extra tool to help you retrieve previous clips.
since i use KDE, this is built in.
