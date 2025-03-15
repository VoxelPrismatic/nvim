local git_cache = {}

local function git_path_key()
	require("rabbit").flags.path_debug = ""
	local path = vim.fn.getcwd()
	if git_cache[path] ~= nil then
		return git_cache[path]
	end

	local git = io.popen("git rev-parse --show-toplevel 2> /dev/null")
	if git == nil then
		error("Could not popen")
	end

	local lines = {}
	for line in git:lines() do
		lines[#lines + 1] = line
	end

	git:close()

	if #lines > 0 then
		git_cache[path] = lines[1]
		return lines[1]
	end

	require("rabbit").flags.path_debug = "No git directory found"
	return path
end

return { ---@type LazyPluginSpec
	"voxelprismatic/rabbit.nvim",
	dir = "/home/priz/Desktop/git/rabbit.nvim",
	-- dir = "/home/priz/Desktop/git/rabbit.legacy",
	lazy = false,
	config = true,
	cmd = "Rabbit",
	---@diagnostic disable-next-line: missing-fields
	opts = { ---@type Rabbit.Config
		keys = {
			switch = "<leader>r",
		},
		cwd = git_path_key,
	},
}
