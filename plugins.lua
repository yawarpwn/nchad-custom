-- local overrides = require "custom.configs.overrides"
---@type NvPluginSpec[]
local plugins = {

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
    end,
    dependencies = {
      {
        "saecki/crates.nvim",
        tag = "v0.4.0",
        opts = {},
      },
      {
        "hrsh7th/cmp-cmdline",
      },
      -- AI Autocomplete
      -- {
      --   "Exafunction/codeium.nvim",
      --   opts = {},
      -- },
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
    opts = require "custom.configs.flash",
  },
    -- Fuzzy Finder
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   init = function()
  --     require("core.utils").load_mappings "telescope"
  --   end,
  --   opts = require "custom.configs.telescope",
  --   dependencies = {
  --     {
  --       "nvim-telescope/telescope-fzf-native.nvim",
  --       build = "make",
  --       enabled = function()
  --         return vim.fn.executable "make" == 1
  --       end,
  --     },
  --   },
  -- },

  -- Native LSP
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- formatting
      {
        "stevearc/conform.nvim",
        -- opts=overrides.conform
        opts = function()
          require "custom.configs.conform"
        end,
      },
      {
        "pmizio/typescript-tools.nvim",
        opts = {
          settings = {
            tsserver_file_preferences = {
              includeInlayParameterNameHints = "all",
              includeCompletionsForModuleExports = true,
              quotePreference = "auto",
            },
          },
        },
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
        opts = require "custom.configs.mason",
      },
      {
        "williamboman/mason-lspconfig.nvim",
      },
      {
        "nvimdev/lspsaga.nvim",
        opts = require "custom.configs.lspsaga",
      },
      {
        "folke/neodev.nvim",
        opts = require "custom.configs.neodev",
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

    -- Notification
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      dofile(vim.g.base46_cache .. "notify")
      require("notify").setup {
        level = 2,
        minimum_width = 50,
        render = "default",
        stages = "fade",
        timeout = 3000,
        top_down = true,
      }

      vim.notify = require "notify"
      local messages = require "custom.core.messages"
      math.randomseed(os.time())
      local randomMessage = messages[math.random(#messages)]
      if vim.g.startup_message then
        vim.notify(randomMessage, vim.log.levels.INFO, { title = "Just For Fun:" })
      end
    end,
  },

  -- Improve UI
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = require "custom.configs.dressing",
  },

  -- Icons
  {
    "nvim-ree/nvim-web-devicons",
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

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSInstallInfo",
      "TSUpdate",
      "TSBufEnable",
      "TSBufDisable",
      "TSEnable",
      "TSDisable",
      "TSModuleInfo",
      "TSToggle",
      "TSBufToggle",
    },
    opts = require "custom.configs.treesitter",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.install").prefer_git = false
      require("nvim-treesitter.configs").setup(opts)
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
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
    opts = require("custom.configs.nvim-tree"),
  },

  -- Preview Colors
  {
    "NvChad/nvim-colorizer.lua",
    opts = require("custom.configs.colorizer"),
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
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  --   ft = "markdown",
  -- },
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
  -- Improve Folds
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.foldmethod = "indent"
    end,
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
            },
          }
        end,
      },
    },
  },

  -- Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = require("custom.configs.todo-comments"),
  },
    -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      require("core.utils").load_mappings "Git"
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
  },

  -- Show diffs
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },

  -- UI for messages, cmdline, and popup
  {
    "folke/noice.nvim",
    lazy = false,
    enabled = false,
    opts = require "custom.configs.noice",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "rcarriga/nvim-notify" },
    },
  }
}

return plugins
