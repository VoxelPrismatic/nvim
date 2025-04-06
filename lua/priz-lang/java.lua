vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		require("rabbit.term.highlight").apply({
			javaTypedef = {
				fg = ":RosePineFgLove",
				bold = true,
				italic = true,
			},
			javaScopeDecl = {
				italic = true,
			},
			["@type"] = {
				fg = nil,
				force = true,
			},
			["@lsp.type.class.java"] = {
				fg = ":RosePineFgIris",
				bold = true,
			},
			javaType = {
				fg = ":RosePineFgRose",
				bold = true,
			},
		})
	end,
	once = true,
})

return {}
