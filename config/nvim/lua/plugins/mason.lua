-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	-- CPP
	clangd = {},

	-- Python
	pyright = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},
	pylsp = {
		plugins = {
			pycodestyles = {
				ignore = { "W391" },
				maxLineLength = 100,
			},
		},
	},

	-- Shell, BASH
	bashls = {
		bashIde = {
			globPattern = "*@(.sh|.inc|.bash|.command)",
		},
	},

	-- Lua
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},

	-- Markdown
	marksman = {},

	-- Cmake
	cmake = {},

	-- Latex
	texlab = {},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

-- mason_lspconfig.setup_handlers({
-- 	function(server_name)
-- 		require("lspconfig")[server_name].setup({
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 			settings = servers[server_name],
-- 		})
-- 	end,
-- })

require("mason-tool-installer").setup({
	ensure_installed = {
		-- CPP
		"cpplint",
		"clang-format",

		-- Python
		"flake8",
		"pylint",
		"isort",
		"autoflake",
		"autopep8",

		-- Lua
		"luacheck",
		"stylua",

		-- Markdown
		"vale",
		"markdownlint",
		"markdown-toc",
		"prettier",

		-- Latex
		"bibtex-tidy",
		"latexindent",
	},

	auto_update = true,
	run_on_start = true,
	start_delay = 3000, -- 3 second delay
})
