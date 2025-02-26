vim.api.nvim_create_autocmd({"BufEnter", "BufLeave"}, {
	pattern = "pad.lua",
	callback = function(evt)
		if evt.event == "BufEnter" then
			require("luapad").attach()
		else
			require("luapad").detach()
			print("LuaPad killed")
		end
	end
})

return {
	'rafcamlet/nvim-luapad',
	lazy = true,
	config = true,
	opts = {
		on_init = function() print("LuaPad started") end
	},
}
