require("nvim-autopairs").setup({
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" },
  check_ts = true,
  ts_config = {
    lua = {'string'},-- it will not add a pair on that treesitter node
    javascript = {'template_string'},
    java = false,-- don't check treesitter on java
  }
})

-- setup cmp for autopairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

local npairs = require('plugins/nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

local ts_conds = require('nvim-autopairs.ts-conds')
-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua")
    :with_pair(ts_conds.is_ts_node({'string','comment'})),
  Rule("$", "$", "lua")
    :with_pair(ts_conds.is_not_ts_node({'function'}))
})
