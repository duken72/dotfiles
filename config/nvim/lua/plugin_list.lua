-- Here is where you install your plugins.
--  You can configure plugins using the `config` key--[[ . --[[ ]] ]]
require('lazy').setup({
  -- Nerd fonts
  "nvim-tree/nvim-web-devicons",
  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- Git releated signs on the left gutter, utilities for managing changes
  'lewis6991/gitsigns.nvim',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Show you pending keybinds
  'folke/which-key.nvim',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {}, tag = 'legacy' },
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          -- vscode format
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }
          -- snipmate format
          require("luasnip.loaders.from_snipmate").load()
          require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }
          -- lua format
          require("luasnip.loaders.from_lua").load()
          require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
          vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
              if
                require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require("luasnip").session.jump_active
              then
                require("luasnip").unlink_current()
              end
            end,
          })
        end,
      },

      { -- autopairing of (){}[] etc
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      { -- cmp sources plugins
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    }
  },

  -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',

  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',

  -- comment visual regions/lines
  "numToStr/Comment.nvim",

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  -- terminal plugin
  'NvChad/nvterm',

  -- Customizable greeter for neovim
  'goolord/alpha-nvim',

  { -- Markdown preview
    "ellisonleao/glow.nvim", config = true, cmd = "Glow"
  },

  -- Markdown TOC
  "mzlogin/vim-markdown-toc",

  -- Symbols Outline
  "simrat39/symbols-outline.nvim",

  -- A file explorer
  -- "nvim-tree/nvim-tree.lua",
})
