local mapkey = require("util.keymapper").mapvimkey
local M = {}

M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	mapkey("<leader>fd", "Lspsaga finder", "n", opts)
	mapkey("<leader>gD", "Lspsaga peek_definition", "n", opts)
	mapkey("<leader>gd", "Lspsaga goto_definition", "n", opts)
	mapkey("<leader>gS", "vsplit | Lspsaga goto_definition", "n", opts)
	mapkey("<leader>ca", "Lspsaga code_action", "n", opts)
	mapkey("<leader>rn", "Lspsaga rename", "n", opts)
	mapkey("<leader>D", "Lspsaga show_line_diagnostics", "n", opts)
	mapkey("<leader>d", "Lspsaga show_cursor_diagnostics", "n", opts)
	mapkey("<leader>pd", "Lspsaga diagnostic_jump_prev", "n", opts)
	mapkey("<leader>nd", "Lspsaga diagnostic_jump_next", "n", opts)
	mapkey("<leader>gi", "Lspsaga finder imp", "n", opts)
	mapkey("K", "Lspsaga hover_doc", "n", opts)

	if client.name == "pyright" then
		mapkey("<leader>oi", "PyrightOrganizeImports", "n", opts)
		mapkey("<leader>db", "DapToggleBreakpoint", "n", opts)
		mapkey("<leader>dr", "DapContinue", "n", opts)
		mapkey("<leader>dt", "lua require('dap-python').test_method()", "n", opts)
	end

	if client.name == "ts_ls" or client.name == "tsserver" then
		mapkey("<leader>oi", "TypeScriptOrganizeImports", "n", opts)
	end
end

M.typescript_organise_imports = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local fname = vim.api.nvim_buf_get_name(bufnr)
	if fname == "" then
		return
	end

	local params = {
		command = "_typescript.organizeImports",
		arguments = { fname },
	}

	local client = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })[1]
		or vim.lsp.get_clients({ bufnr = bufnr, name = "tsserver" })[1]

	if not client then
		vim.notify("No ts_ls/tsserver client attached to this buffer", vim.log.levels.WARN)
		return
	end

	if client.exec_cmd then
		-- New API
		client:exec_cmd(params, { bufnr = bufnr })
	else
		-- Non-deprecated fallback: proper colon call + handler
		client:request("workspace/executeCommand", params, function(err)
			if err then
				vim.notify("Organize Imports failed: " .. (err.message or tostring(err)), vim.log.levels.ERROR)
			end
		end, bufnr)
		-- Alternatively:
		-- vim.lsp.buf_request(bufnr, "workspace/executeCommand", params, function(err) ... end)
	end
end

return M
