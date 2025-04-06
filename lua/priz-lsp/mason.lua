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

vim.keymap.set("n", "<leader>lh", ToggleHarperLs, {
	desc = "Harper LS",
	noremap = true,
	silent = true,
})

---@type { [string]: boolean }
local types = {}

MASON = {
	registry = nil,
	mapping = nil,
	reverse_mapping = nil,
	lspconfig = nil,
	nvimlsp = nil,

	---@type { [string]: { [string]: boolean } }
	langs = {},
}

---@type { [string]: integer }
local launch = {}

vim.api.nvim_create_autocmd("FileType", {
	callback = function(evt)
		if types[evt.match] then
			return
		elseif MASON.langs[evt.match] == nil then
			types[evt.match] = true
			return
		end

		local lspname = vim.tbl_keys(MASON.langs[evt.match])[1]
		local mason_name = MASON.reverse_mapping[lspname] or lspname
		launch[mason_name] = evt.buf
		MASON.registry.get_package(mason_name):install({ debug = true, force = true })
		types[evt.match] = true
	end,
})

local ignore = {
	"grammarly",
}

local manual_link = {
	["c3-lsp"] = "c3_lsp",
}

local function get_lspname(pkgname)
	local lspname = MASON.mapping[pkgname] or pkgname
	if manual_link[lspname] then
		lspname = manual_link[lspname]
		MASON.reverse_mapping[lspname] = pkgname
	end
	return lspname
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
		-- priority = 300,
		-- event = { "BufRead", "BufNewFile", "FileType" },
		config = function(_)
			MASON.nvimlsp = require("lspconfig")
			MASON.lspconfig = require("mason-lspconfig")
			MASON.lspconfig.setup({
				automatic_installation = true,
				ensure_installed = {},
			})

			MASON.registry = require("mason-registry")
			MASON.registry.update()
			MASON.registry:on("package:install:success", function(pkg)
				vim.schedule(function()
					if launch[pkg.name] == nil then
						return
					end
					local lsp = MASON.nvimlsp[get_lspname(pkg.name)]
					lsp.setup({})
					lsp.launch(launch[pkg.name])
					launch[pkg.name] = nil
				end)
			end)
			local packages = MASON.registry.get_all_package_specs()

			local mapping = require("mason-lspconfig.mappings.server")
			MASON.mapping = mapping.package_to_lspconfig
			MASON.reverse_mapping = mapping.lspconfig_to_package

			for _, pkg in ipairs(packages) do
				local is_lsp = false
				for _, cat in ipairs(pkg.categories) do
					if cat == "LSP" then
						is_lsp = true
						break
					end
				end

				if not is_lsp or pkg.name == nil then
					-- Not an LSP
					goto continue
				end

				local lspname = get_lspname(pkg.name)
				for _, ignored in ipairs(ignore) do
					if ignored == lspname then
						goto continue
					end
				end

				local ok = pcall(require, "lspconfig.configs." .. lspname)

				if not ok then
					-- LSP doesn't exist
					goto continue
				end

				local lspconfig = MASON.nvimlsp[lspname]
				local is_installed = MASON.registry.is_installed(pkg.name)
				local fts = lspconfig.config_def.default_config.filetypes or {}

				if is_installed then
					lspconfig.setup({})
				end

				if #fts >= 8 or #pkg.languages >= 8 or pkg.deprecation then
					-- These are not LSPs (eg grammar checkers)
					goto continue
				end

				for _, ft in ipairs(fts) do
					-- LspConfig exists; do not try to install new LSPs
					types[ft] = types[ft] or is_installed
					if MASON.langs[ft] == nil then
						MASON.langs[ft] = { [lspname] = is_installed }
					else
						MASON.langs[ft][lspname] = is_installed
					end
				end

				::continue::
			end

			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = {
					current_line = true,
				},
			})
		end,
	},
}
