local opts = {
  relative_width = true,
  auto_close = true,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  autofold_depth = 2,
  auto_unfold_hover = true,
  wrap = false,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = {"<Esc>", "q"},
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  symbols = {
    File = { icon = "", hl = "@text.uri" },
    Module = { icon = "", hl = "@namespace" },
    Namespace = { icon = "", hl = "@namespace" },
    Package = { icon = "󱉟", hl = "@namespace" },
    Method = { icon = "ƒ", hl = "@method" },
    Property = { icon = "", hl = "@method" },
    Class = { icon = "C", hl = "@type" },
    Struct = { icon = "", hl = "@type" },
    Object = { icon = "", hl = "@type" },
    Key = { icon = "", hl = "@type" },
    Null = { icon = "NULL", hl = "@type" },
    Event = { icon = "🗲", hl = "@type" },
    Enum = { icon = "", hl = "@type" },
    Interface = { icon = "ﰮ", hl = "@type" },
    Field = { icon = "", hl = "@field" },
    Constructor = { icon = "", hl = "@constructor" },
    Function = { icon = "", hl = "@function" },
    Variable = { icon = "", hl = "@constant" },
    Constant = { icon = "", hl = "@constant" },
    String = { icon = "󰊄", hl = "@string" },
    Number = { icon = "#", hl = "@number" },
    Boolean = { icon = "", hl = "@boolean" },
    Array = { icon = "", hl = "@constant" },
    Operator = { icon = "+", hl = "@operator" },
  },
}

require("symbols-outline").setup({
  cmd = "SymbolsOutline",
  config = true,
  opts = opts,
})

vim.keymap.set('n', '<leader>so', "<cmd>SymbolsOutline<cr>",
  { desc = 'Symbols Outline' }
)
