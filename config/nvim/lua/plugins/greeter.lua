-- [[ Configure greeter ]]
local greeter = require("alpha.themes.dashboard")
greeter.section.header.opts = { position = 'center', hl = 'AlphaCol1' }
greeter.section.header.val = {
  [[     __       __             ____ ___ ]],
  [[ ___/ /__ __ / /__ ___  ___ /_  /|_  |]],
  [[/ _  // // //  '_// -_)/ _ \ / // __/ ]],
  [[\___/ \___//_/\_\ \__//_//_//_//____/ ]],
}

greeter.section.buttons.val = {
    greeter.button( "e",        "  New file" , ":ene <BAR> startinsert <CR>"),
    greeter.button( "Spc ?",    "  Recent"   , ":Telescope oldfiles<CR>"),
    greeter.button( "Spc sf",   "  Find file", ":Telescope find_files<CR>"),
    greeter.button( "Spc sg",   "󰈬  Find word", ":Telescope grep_string<CR>"),
    greeter.button( "q",        "  Quit"     , ":qa<CR>"),
}

greeter.section.footer.val = {
  ' ' .. #vim.tbl_keys(require("lazy").plugins()) .. ' plugins ' ..
  "-- NEOVIM v" .. vim.version().major .. '.' .. vim.version().minor .. '.' .. vim.version().patch
}

require('alpha').setup(require'alpha.themes.dashboard'.config)
