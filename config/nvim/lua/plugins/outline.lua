require("outline").setup({
	-- cmd = "Outline",
	-- config = true,
	outline_window = {
		relative_width = true,
		auto_close = true,
		wrap = false,
	},
	outline_items = {
		show_symbol_details = true,
	},
	-- preview_bg_highlight = "Pmenu",
	symbol_folding = {
		autofold_depth = 2,
		auto_unfold = {
			hovered = true,
		},
	},
	preview_window = {
		-- auto_preview = true,
	},

	-- '?': show current keymaps in floating window

	symbols = {
		-- Defaults use math-script letters (𝓒 𝓐 𝓢 𝙏), which no installed font covers
		icons = {
			Class = { icon = "", hl = "Type" },
			String = { icon = "", hl = "String" },
			Struct = { icon = "", hl = "Structure" },
			TypeParameter = { icon = "", hl = "Identifier" },
		},
		filter = {
			default = { "String", exclude = true },
			python = { "Function", "Class" },
		},
	},
})

vim.keymap.set("n", "<leader>so", "<cmd>Outline<cr>", { desc = "Toggle Outline" })
