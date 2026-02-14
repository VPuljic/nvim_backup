return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		views = {
			notify = {
				-- ⬅ Position notifications in top-right corner
				backend = "notify",
				render = "compact",
				replace = true,
			},
			mini = {
				timeout = 3000,
			},
			cmdline_popup = {
				position = {
					row = "50%", -- ⬅ Centered vertically
					col = "50%", -- ⬅ Centered horizontally
				},
				size = {
					width = 60,
					height = "auto",
				},
				border = {
					style = "rounded",
				},
				win_options = {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = "60%", -- slightly below center
					col = "50%",
				},
				size = {
					width = 60,
					height = 10,
				},
				border = {
					style = "rounded",
				},
				win_options = {
					winhighlight = "NormalFloat:Pmenu,FloatBorder:PmenuBorder",
				},
			},
		},
		routes = {
			{
				view = "notify", -- ⬅ Ensures showmode goes to notify (top right)
				filter = { event = "msg_showmode" },
			},
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = false, -- ⬅ disable bottom search
			command_palette = false, -- ⬅ disable side-by-side cmdline/popupmenu
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			opts = {
				timeout = 3000,
				render = "compact",
				top_down = false,
				background_colour = "#000000",
				fade_in_slide_out = true,
			},
		},
	},
}
