local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.icons").diagnostic_signs
local typescript_organise_imports = require("util.lsp").typescript_organise_imports

local config = function()
	require("neoconf").setup({})
	local caps = require("cmp_nvim_lsp").default_capabilities()
	local util = require("lspconfig.util")

	vim.lsp.config("gopls", {
		capabilities = caps,
		on_attach = on_attach,
	})

	vim.lsp.config("solidity_ls", {
		capabilities = caps,
		on_attach = on_attach,
		filetypes = { "solidity" },
		root_dir = util.root_pattern("hardhat.config.*", "foundry.toml", "remappings.txt", ".git"),
		settings = {
			solidity = {
				includePath = "",
				remappings = {
					["@openzeppelin/"] = "lib/openzeppelin-contracts/",
					["account-abstraction/"] = "lib/account-abstraction/",
				},
			},
		},
	})

	vim.lsp.config("lua_ls", {
		capabilities = caps,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
					},
				},
			},
		},
	})

	vim.lsp.config("jsonls", {
		capabilities = caps,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})

	vim.lsp.config("pyright", {
		capabilities = caps,
		on_attach = on_attach,
		settings = {
			pyright = { disableOrganizeImports = false },
			python = {
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	vim.lsp.config("ts_ls", {
		capabilities = caps,
		on_attach = on_attach,
		filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
		settings = { typescript = { indentStyle = "space", indentSize = 2 } },
	})

	vim.api.nvim_create_user_command("TypeScriptOrganizeImports", typescript_organise_imports, {})

	vim.lsp.config("bashls", {
		capabilities = caps,
		on_attach = on_attach,
		filetypes = { "sh", "aliasrc" },
	})

	vim.lsp.config("emmet_ls", {
		capabilities = caps,
		on_attach = on_attach,
		filetypes = {
			"typescriptreact",
			"javascriptreact",
			"javascript",
			"css",
			"sass",
			"scss",
			"less",
			"svelte",
			"vue",
			"html",
		},
	})

	vim.lsp.config("dockerls", {
		capabilities = caps,
		on_attach = on_attach,
	})

	vim.lsp.config("clangd", {
		capabilities = caps,
		on_attach = on_attach,
		cmd = { "clangd", "--offset-encoding=utf-16" },
	})

	local gofumpt = require("efmls-configs.formatters.gofumpt")
	local go_revive = require("efmls-configs.linters.go_revive")
	local solhint = require("efmls-configs.linters.solhint")
	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local eslint = require("efmls-configs.linters.eslint")
	local fixjson = require("efmls-configs.formatters.fixjson")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local hadolint = require("efmls-configs.linters.hadolint")
	local cpplint = require("efmls-configs.linters.cpplint")
	local clangformat = require("efmls-configs.formatters.clang_format")

	vim.lsp.config("efm", {
		filetypes = {
			"solidity",
			"lua",
			"python",
			"json",
			"jsonc",
			"sh",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
			"vue",
			"markdown",
			"docker",
			"html",
			"css",
			"c",
			"cpp",
			"go",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				solidity = { solhint, prettier_d },
				lua = { luacheck, stylua },
				python = { flake8, black },
				json = { eslint, fixjson },
				jsonc = { eslint, fixjson },
				sh = { shellcheck, shfmt },
				javascript = { eslint, prettier_d },
				javascriptreact = { eslint, prettier_d },
				typescript = { eslint, prettier_d },
				typescriptreact = { eslint, prettier_d },
				svelte = { eslint, prettier_d },
				vue = { eslint, prettier_d },
				markdown = { prettier_d },
				docker = { hadolint, prettier_d },
				html = { prettier_d },
				css = { prettier_d },
				c = { clangformat, cpplint },
				cpp = { clangformat, cpplint },
				go = { gofumpt, go_revive },
			},
		},
	})

	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	vim.lsp.enable({
		"gopls",
		"solidity_ls",
		"lua_ls",
		"jsonls",
		"pyright",
		"ts_ls",
		"bashls",
		"emmet_ls",
		"dockerls",
		"clangd",
		"efm",
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
