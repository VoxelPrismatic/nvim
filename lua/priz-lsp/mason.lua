local capabilities = vim.lsp.protocol.make_client_capabilities()

local running = true

function ToggleHarperLs()
	if not running then
		running = true
		vim.print("Starting Harper LS")
		require("lspconfig")["harper_ls"].setup({
			capabilities = capabilities,
			settings = {},
			flags = { debounce_text_changes = 300 },
		})
		return
	end

	for _, client in ipairs(vim.lsp.get_clients()) do
		if client.name == "harper_ls" then
			vim.print("Killing Harper LS")
			client:stop(true)
			if not pcall(vim.cmd, "edit") then
				vim.print("Save and run \\lh again to kill harper_ls")
				return
			end
			running = false
			return
		end
	end
end

vim.diagnostic.config({
	virtual_text = {
		current_line = false,
	},
	virtual_lines = {
		current_line = true,
	},
})

vim.keymap.set("n", "<leader>lh", ToggleHarperLs, {
	desc = "Harper LS",
	noremap = true,
	silent = true,
})

-- Mason Lsp Config is not complete
---@type table<string, string>
local manual_link = {
	["c3-lsp"] = "c3_lsp",
}

local GENERIC_THRESHOLD = 8

---@type { [string]: boolean }
local handled = {
	grammarly = true, -- Disable grammarly install
}

---@type { [string]: boolean }
local deprecated = {
	volar = true,
}

---@type { [string]: integer }
local _bound = {}

---@return boolean success
local function launch_lsp(name, bufnr)
	local active = vim.lsp.get_clients({ name = name })
	if #active > 0 or _bound[name] ~= nil then
		return true
	end
	vim.print("Launching " .. name)
	local lsp = require("lspconfig")[name]
	lsp.setup({})
	_bound[name] = vim.lsp.start(lsp, {
		bufnr = bufnr or 0,
	})
	return _bound[name] ~= nil
end

local handling_lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(evt)
		if handling_lsp then
			return
		end

		handling_lsp = true
		local lsps = {}
		for _, lsp in ipairs(vim.lsp.get_clients()) do
			if lsps[lsp.name] == nil then
				lsps[lsp.name] = lsp
				goto continue
			end

			-- Bind this buffer to the existing LSP instance
			for bufid, attached in pairs(lsp.attached_buffers) do
				if attached then
					vim.lsp.buf_detach_client(bufid, lsp.id)
				end
				if not lsps[lsp.name].attached_buffers[evt.buf] then
					vim.lsp.buf_attach_client(bufid, lsps[lsp.name].id)
				end
			end
			lsp:stop(true)

			::continue::
		end
		handling_lsp = false
	end,
})

---@param evt vim.api.keyset.create_autocmd.callback_args
---@param ft string
local function bind_lsp(evt, ft)
	local map = require("mason-lspconfig").get_mappings()
	local mason = {
		lsp = require("mason-lspconfig"),
		dap = require("mason-nvim-dap"),
		registry = require("mason-registry"),
		main = require("mason"),
	}
	for mason_name, lsp_name in pairs(manual_link) do
		map.lspconfig_to_package[lsp_name] = mason_name
		map.package_to_lspconfig[mason_name] = lsp_name
	end

	---@type { [string]: true }
	local installed = {}
	for _, name in ipairs(mason.lsp.get_installed_servers()) do
		installed[name] = true
	end

	---@param tries string[]
	---@return vim.lsp.Config? config
	---@return string lsp_name
	local matches_ft = function(tries)
		for _, lsp_name in ipairs(tries) do
			local config = vim.lsp.config[lsp_name] or {}
			for _, t in ipairs(config.filetypes or {}) do
				if t == ft then
					return config, lsp_name
				end
			end
		end
		return nil, ""
	end

	local pkgs = {} ---@type Package[]
	local found = false

	---@param pkg Package
	local update_pkg = function(pkg)
		local current = pkg:get_installed_version()
		local latest = pkg:get_latest_version()

		local name = map.package_to_lspconfig[pkg.name]

		if current == nil then
			table.insert(pkgs, pkg)
		elseif current ~= latest then
			pkg:install({
				force = false,
				strict = false,
				version = latest,
			})
		else
			found = launch_lsp(name) or found
		end
	end

	for name, _ in pairs(map.lspconfig_to_package) do
		if deprecated[name] then
			goto continue
		end

		local tries = {
			map.package_to_lspconfig[name] or name,
			name,
		}

		local config, lsp_name = matches_ft(tries)

		if config == nil then
			goto continue
		end

		local binaries = config.cmd
		if type(binaries) == "table" and vim.fn.executable(binaries[1]) == 1 then
			launch_lsp(lsp_name, evt.buf)
		end

		local fts = config.filetypes or {}
		if #fts >= GENERIC_THRESHOLD or map.lspconfig_to_package[name] == nil then
			goto continue
		end

		local ok, pkg = pcall(mason.registry.get_package, map.lspconfig_to_package[name])
		if not ok then
			-- pass
		elseif installed[name] then
			update_pkg(pkg)
		else
			table.insert(pkgs, pkg)
		end
		::continue::
	end

	if found then
		return
	end

	local pkg = table.remove(pkgs, 1) ---@type Package?
	if pkg == nil then
		vim.print("No LSP available for filetype `" .. ft .. "'")
		return
	end

	vim.print("Installing LSP `" .. pkg.name .. "' for filetype `" .. ft .. "'")
	pkg:install()
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufRead" }, {
	pattern = { "*" },
	callback = function(evt)
		local ft = vim.bo[evt.buf or 0].filetype
		if ft == nil or ft == "" or handled[ft] then
			return
		end

		handled[ft] = true

		vim.defer_fn(function()
			bind_lsp(evt, ft)
		end, 50)
	end,
})

return { ---@type LazyPluginSpec[]
	{
		"williamboman/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", name = "mason" },
			{ "neovim/nvim-lspconfig" },
			{ "jay-babu/mason-nvim-dap.nvim" },
		},
		lazy = false,
		config = function(_)
			require("mason").setup({
				pip = {
					upgrade_pip = true,
				},
			})
			local registry = require("mason-registry")

			local mapping = require("mason-lspconfig").get_mappings()
			for mason_name, lsp_name in pairs(manual_link) do
				mapping.package_to_lspconfig[mason_name] = lsp_name
				mapping.lspconfig_to_package[lsp_name] = mason_name
			end

			-- Launch LSP immediately upon installation
			registry:on(
				"package:install:success",
				vim.schedule_wrap(function(pkg) ---@param pkg Package
					local is_lsp = false
					for _, category in ipairs(pkg.spec.categories) do
						if category == "LSP" then
							is_lsp = true
							break
						end
					end

					if is_lsp then
						launch_lsp(mapping.package_to_lspconfig[pkg.name] or pkg.name)
					end
				end)
			)

			local mason_dap = require("mason-nvim-dap")

			mason_dap.setup({
				automatic_installation = true,
				ensure_installed = {},
				handlers = {
					mason_dap.default_setup,
				},
			})
		end,
	},
}
