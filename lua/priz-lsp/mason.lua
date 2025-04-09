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
	virtual_text = true,
	virtual_lines = {
		current_line = true,
	},
})

vim.keymap.set("n", "<leader>lh", ToggleHarperLs, {
	desc = "Harper LS",
	noremap = true,
	silent = true,
})

-- Run updates on these packages
---@type table<string, string | false>
local updateable = {
	grammarly = false, -- Ignore Grammarly
}

-- Do not bind multiple LSPs to the same filetype
---@type table<string, integer>
local autocmds = {}

-- Mason Lsp Config is not complete
---@type table<string, string>
local manual_link = {
	["c3-lsp"] = "c3_lsp",
}

local GENERIC_THRESHOLD = 8

local nvim_lsp ---@type table<string, table>
local mason_lsp
local mapping ---@type { lspconfig_to_package: table<string, string>, package_to_lspconfig: table<string, string>}
local registry ---@type MasonRegistry

---@param lsp_name string LSP name, as found in lspconfig
local function bind_lsp(lsp_name)
	---@type boolean | string | Package
	local pkg = updateable[lsp_name]
	if type(pkg) == "string" then
		-- Auto-update
		pkg = registry.get_package(pkg)
		pkg:check_new_version(function(_ok, version)
			if _ok and version.current_version ~= version.latest_version then
				pkg:install()
			end
		end)
		return
	elseif pkg ~= nil then
		return
	end

	local lsp = nvim_lsp[lsp_name]
	local fts = lsp.config_def ~= nil and lsp.config_def.default_config.filetypes or {}
	-- Generic LSP like harper_ls, not specific to language
	if #fts > GENERIC_THRESHOLD or #fts == 0 then
		return
	end

	local mason_name = mapping.lspconfig_to_package[lsp_name] or lsp_name
	pkg = registry.get_package(mason_name)
	-- Generic LSP like harper_ls, not specific to language
	if #pkg.spec.languages > GENERIC_THRESHOLD then
		return
	end

	local buf_fts = {}
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		table.insert(buf_fts, vim.bo[bufnr].filetype)
	end

	-- Install the first LSP for each filetype
	for _, ft in ipairs(fts) do
		if autocmds[ft] ~= nil then
			-- pass
		elseif vim.tbl_contains(buf_fts, ft) then
			pkg:install()
		else
			autocmds[ft] = vim.api.nvim_create_autocmd("FileType", {
				pattern = ft,
				callback = function()
					pkg:install()
				end,
				once = true,
			})
		end
	end
end

return { ---@type LazyPluginSpec[]
	{
		"williamboman/mason.nvim",
		name = "mason",
		build = ":MasonUpdate",
		config = true,
		opts = { ---@type MasonSettings
			pip = {
				upgrade_pip = true,
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", name = "mason" },
			{ "neovim/nvim-lspconfig" },
		},
		lazy = false,
		config = function(_)
			nvim_lsp = require("lspconfig")
			mason_lsp = require("mason-lspconfig")
			mapping = require("mason-lspconfig.mappings.server")
			registry = require("mason-registry")

			for mason_name, lsp_name in pairs(manual_link) do
				mapping.package_to_lspconfig[mason_name] = lsp_name
				mapping.lspconfig_to_package[lsp_name] = mason_name
			end

			mason_lsp.setup({
				automatic_installation = true,
				ensure_installed = {},
			})

			mason_lsp.setup_handlers({
				function(lsp_name)
					local lsp = nvim_lsp[lsp_name]
					updateable[lsp_name] = mapping.lspconfig_to_package[lsp_name] or lsp_name
					lsp.setup({})
					local fts = lsp.config_def ~= nil and lsp.config_def.default_config.filetypes or {}
					if #fts < GENERIC_THRESHOLD then
						for _, ft in ipairs(fts) do
							autocmds[ft] = 0
						end
					end
				end,
			})

			-- Launch LSP immediately upon installation
			registry:on(
				"package:install:success",
				vim.schedule_wrap(function(pkg)
					local lsp = nvim_lsp[mapping.package_to_lspconfig[pkg.name] or pkg.name]
					lsp.setup({})
					lsp.launch()
				end)
			)

			registry.update(vim.schedule_wrap(function(ok, msg)
				if not ok then
					error(msg)
				end
				for _, lsp_name in ipairs(mason_lsp.get_available_servers()) do
					bind_lsp(lsp_name)
				end
			end))
		end,
	},
}
