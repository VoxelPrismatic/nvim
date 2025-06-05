---@class FmtCmd
local FmtCmd = {
	---@type string
	bin = "",

	---@type { [string | integer]: string}
	flags = {},

	---@type string[]
	args = {},
}

---@param flags? {[string|integer]:string}
---@return FmtCmd
function FmtCmd:plus(flags)
	local copy = vim.deepcopy(self)
	copy.flags = vim.tbl_deep_extend("force", self.flags, flags or {})
	return copy
end

---@param tbl {bin: string, flags: {[any]:string}, args: string[]}
function FmtCmd:new(tbl)
	return setmetatable(tbl, { __index = FmtCmd })
end

---@return string cmd
function FmtCmd:make()
	local parts = { self.bin }
	for key, val in pairs(self.flags) do
		if type(key) == "number" then
			table.insert(parts, key)
		elseif key:find("--", 1, true) == 1 then
			table.insert(parts, key .. "=" .. val)
		else
			table.insert(parts, key)
			table.insert(parts, val)
		end
	end
	for _, arg in ipairs(self.args) do
		table.insert(parts, arg)
	end
	return table.concat(parts, " ")
end

---@type {[string]:FmtCmd}
local exe = {
	stylua = FmtCmd:new({
		bin = "stylua",
		flags = {
			["--syntax"] = "LuaJIT",
		},
		args = { "%" },
	}),
	clang = FmtCmd:new({
		bin = "clang-format",
		flags = {
			["--style"] = "file",
			["-i"] = "%",
		},
	}),
	prettier = FmtCmd:new({
		bin = "prettier",
		flags = {
			["-w"] = "%",
		},
	}),
}

local formatters = {
	-- c = exe.clang:plus(),
	java = exe.clang:plus(),
	markdown = exe.prettier:plus(),
	html = exe.prettier:plus(),
	lua = exe.stylua:plus(),
	json = exe.prettier:plus({
		["--config"] = "/home/priz/.config/nvim/fmt/json.prettier.json",
	}),
}

-- Delete trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	desc = "Delete trailing spaces on save, and format file",
	callback = function(evt)
		vim.cmd([[%s/\s\+$//e]])
		if formatters[vim.bo[evt.buf].filetype] ~= nil then
			return
		end

		local clients = vim.lsp.get_clients({
			bufnr = evt.buf,
			method = "textDocument/formatting",
		})

		if #clients == 0 then
			return
		end

		local tabstop = vim.bo.tabstop
		local expandtab = vim.bo.expandtab
		local shiftwidth = vim.bo.shiftwidth
		vim.lsp.buf.format()
		for i = 0, 1000, 100 do
			vim.defer_fn(function()
				vim.bo.tabstop = tabstop
				vim.bo.expandtab = expandtab
				vim.bo.shiftwidth = shiftwidth
			end, i)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*" },
	desc = "Format file post-save",
	callback = function(evt)
		local cb = formatters[vim.bo[evt.buf].filetype]

		if cb == nil then
			return
		end

		local tabstop = vim.bo.tabstop
		local expandtab = vim.bo.expandtab
		local shiftwidth = vim.bo.shiftwidth
		vim.cmd("silent! !" .. cb:make())
		for i = 0, 1000, 100 do
			vim.defer_fn(function()
				vim.bo.tabstop = tabstop
				vim.bo.expandtab = expandtab
				vim.bo.shiftwidth = shiftwidth
			end, i)
		end
	end,
})

return {}
