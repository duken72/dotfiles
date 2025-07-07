local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		-- Conform will run multiple formatters sequentially
		-- Use a sub-list to run only the first available formatter
		-- javascript = { { "prettierd", "prettier" } },
		lua = { "stylua" },
		python = { "isort", "autopep8", "autoflake" }, -- "black"
		latex = { "latexindent", "bibtex-tidy" },
		cpp = { "clang-format" },
		shell = { "shfmt" },
		bash = { "shfmt" },
		markdown = { "markdown-toc", "markdownlint", "prettier" },
	},

	formatters = {
		clang_format = {
			prepend_args = {
				"--style='{BasedOnStyle: llvm, IndentWidth: 4, SpacesBeforeTrailingComments: 2}'",
			},
		},
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
