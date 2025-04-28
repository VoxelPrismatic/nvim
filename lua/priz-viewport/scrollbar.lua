return {
	"dstein64/nvim-scrollview",
	event = "UIEnter",
	config = function()
		vim.g.scrollview_diagnostics_error_symbol = ""
		vim.g.scrollview_diagnostics_hint_symbol = "󱐋"
		vim.g.scrollview_diagnostics_info_symbol = ""
		vim.g.scrollview_diagnostics_warn_symbol = "󰔶"
	end,
}
