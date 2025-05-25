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

```bash
cd ~/.config/nvim
git reset --hard
git pull
```

# Details

### Theme

**Main:** Rose Pine Dawn (my fork)
**Lualine:** Neutral, with mods to the inactive bar

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

### Screenshot

![Screenshot_20240517_203623](https://github.com/VoxelPrismatic/nvim/assets/45671764/636d254b-34c1-4415-ab21-5f7f15109027)
![Screenshot_20240517_203909](https://github.com/VoxelPrismatic/nvim/assets/45671764/f9df0df4-3701-46c9-a9b4-4d88fabfbe98)
