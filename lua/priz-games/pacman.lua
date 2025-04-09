if vim.uv.fs_stat("/home/priz/Desktop/git/pacman.nvim") == nil then
	return {}
end

return {
	"voxelprismatic/pacman.nvim",
	lazy = false,
	dir = "/home/priz/Desktop/git/pacman.nvim",
}
