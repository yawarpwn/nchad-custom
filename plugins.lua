local overrides = require "custom.configs.overrides"
---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = function()
      local cmp = require "cmp"
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "cmdline" },
        },
      })

      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    dependencies = {
      {
        "hrsh7th/cmp-cmdline",
      },
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
      },
    },
  },

  -- Search motions
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = overrides.flash,
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = {
  --     -- format & linting
  --     {
  --       "jose-elias-alvarez/null-ls.nvim",
  --       config = function()
  --         require "custom.configs.null-ls"
  --       end,
  --     },
  --   },
  --   config = function()
  --     require "plugins.configs.lspconfig"
  --     require "custom.configs.lspconfig"
  --   end, -- Override to setup mason-lspconfig
  -- },
  -- Native LSP
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- formatting
      {
        "stevearc/conform.nvim",
        opts = overrides.conform,
      },
      {
        "williamboman/mason.nvim",
        cmd = {
          "Mason",
          "MasonInstall",
          "MasonUpdate",
          "MasonUninstall",
          "MasonUninstallAll",
          "MasonLog",
        },
        opts = overrides.mason,
      },
      {
        "williamboman/mason-lspconfig.nvim",
      },
      {
        "nvimdev/lspsaga.nvim",
        opts = overrides.lspsaga,
      },
      {
        "folke/neodev.nvim",
        opts = overrides.neodev,
      },
    },
    config = function()
      dofile(vim.g.base46_cache .. "lsp")
      require "nvchad.lsp"
      require "custom.configs.lspconfig"
    end,
  },

  --Alternativeto Copilot 
  {
    "Exafunction/codeium.vim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })

      vim.g.codeium_filetypes = {
        ["TelescopePrompt"] = false,
      }
    end,
  },

  -- Schemas
  { "b0o/schemastore.nvim" },

  -- Improve UI
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = overrides.dressing,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override_by_extension = {
        ["astro"] = {
          icon = "󱓞",
          color = "#FF7E33",
          name = "astro",
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
    },
  },
    -- Commenter
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        -- ignores empty lines
        ignore = "^$",
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = overrides.colorizer,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "insertenter",
    config = function()
      require("better_escape").setup()
    end,
  },
  -- Buffer Delete
  {
    "moll/vim-bbye",
    cmd = { "Bdelete", "Bwipeout" },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  -- Preview Markdown
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>x", desc = "Trouble" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Document Diagnostics" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Quickfix List Trouble" },
    },
    opts = {
      use_diagnostic_signs = true,
      action_keys = {
        close = { "q", "<esc>" },
        cancel = "<C-e>",
      },
    },
  },
  -- Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    event ='VeryLazy',
    opts = overrides.todo_comments
  },
    -- Show diffs
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },
  -- {
  --   'kkharji/sqlite.lua',
  --   config= function()
  --     end
  -- }

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loade by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
