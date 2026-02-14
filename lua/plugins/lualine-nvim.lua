local config = function()
	local palette = require("nightfox.palette").load("carbonfox")
	local custom_nightfox = require("lualine.themes.nightfox")
	custom_nightfox.normal.b.bg = palette.bg0

	local hide_in_width = function()
		return vim.fn.winwidth(0) > 100
	end

	local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn" },
		symbols = { error = " ", warn = " ", info = " ", hint = " " },
		colored = false,
		update_in_insert = false,
		always_visible = false,
		cond = hide_in_width,
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = custom_nightfox,
			globalstatus = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "|", right = "|" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "buffers" },
			lualine_x = { "branch", diagnostics },
			lualine_y = { "encoding", "fileformat", "filetype", "progress" },
			lualine_z = { "location" },
		},
		tabline = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
