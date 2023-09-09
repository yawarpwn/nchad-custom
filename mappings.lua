---@type MappingsTable
local M = {}
local fn = vim.fn

M.general = {
  i = {

    ["<A-j>"] = {
      "<Esc>:m .+1<CR>==gi",
      "Move the line up",
      opts = { silent = true },
    },

    ["<A-k>"] = {
      "<Esc>:m .-2<CR>==gi",
      "Move the line down",
      opts = { silent = true },
    },
  },
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    [">"] = {
      ">>",
      "Indent forward",
      opts = { silent = true },
    },

    ["<A-j>"] = {
      ":m .+1<CR>==",
      "Move the line up",
      opts = { silent = true },
    },

    ["<A-k>"] = {
      ":m .-2<CR>==",
      "Move the line down",
      opts = { silent = true },
    },
  },
  v = {
    ["<"] = {
      "<gv",
      "Indent backward",
      opts = { silent = true },
    },

    [">"] = {
      ">gv",
      "Indent forward",
      opts = { silent = true },
    },

    ["<A-j>"] = {
      ":m '>+1<CR>gv=gv",
      "Move the selected text up",
      opts = { silent = true },
    },

    ["<A-k>"] = {
      ":m '<-2<CR>gv=gv",
      "Move the selected text down",
      opts = { silent = true },
    },
  },
  x = {
    ["<A-j>"] = {
      ":m '>+1<CR>gv=gv",
      "Move the selected text up",
      opts = { silent = true },
    },

    ["<A-k>"] = {
      ":m '<-2<CR>gv=gv",
      "Move the selected text down",
      opts = { silent = true },
    },
  },
  c = {
    ["<Tab>"] = {
      function()
        if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
          return "<CR>/<C-r>/"
        end
        return "<C-z>"
      end,
      "Word Search Increment",
      opts = { expr = true },
    },

    ["<S-Tab>"] = {
      function()
        if fn.getcmdtype() == "/" or fn.getcmdtype() == "?" then
          return "<CR>?<C-r>/"
        end
        return "<S-Tab>"
      end,
      "Word Search Decrement",
      opts = { expr = true },
    },
  },
}
M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-3>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-1>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-2>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-3>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-1>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-2>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },
}
M.LSP = {
  n = {
    ["<leader>lf"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },

    ["<leader>lr"] = {
      function()
        require("nvchad.renamer").open()
      end,
      "LSP rename",
    },

    -- ["<leader>la"] = { ":Lspsaga code_action<cr>", "Code Action", opts = { silent = true } },
    -- ["<leader>li"] = { ":LspInfo<cr>", "Info", opts = { silent = true } },
    -- ["<leader>lo"] = { ":Lspsaga outline<cr>", "Code Outline", opts = { silent = true } },
    -- ["<leader>lI"] = { ":Lspsaga incoming_calls<cr>", "Incoming Calls", opts = { silent = true } },
    -- ["<leader>lO"] = { ":Lspsaga outgoing_calls<cr>", "Outgoing Calls", opts = { silent = true } },
    -- ["<leader>lm"] = { ":Mason<cr>", "Mason Installer", opts = { silent = true } },
    -- ["<leader>lj"] = {
    --   ":Lspsaga diagnostic_jump_next<cr>",
    --   "Next Diagnostic",
    --   opts = { silent = true },
    -- },
    -- ["<leader>lk"] = {
    --   ":Lspsaga diagnostic_jump_prev<cr>",
    --   "Prev Diagnostic",
    --   opts = { silent = true },
    -- },

    -- ["<leader>ld"] = { ":Telescope diagnostics bufnr=0<cr>", "Document Diagnostics", opts = { silent = true } },
    -- ["<leader>lw"] = { ":Telescope diagnostics<cr>", "Workspace Diagnostics", opts = { silent = true } },
    -- ["<leader>ls"] = { ":Telescope lsp_document_symbols<cr>", "Document Symbols", opts = { silent = true } },
    -- ["<leader>lS"] = { ":Telescope lsp_workspace_symbols<cr>", "Workspace Symbols", opts = { silent = true } },
  },
}
M.tabufline = {
  plugin = true,

  n = {
    -- cycle through buffers
    ["<S-L>"] = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<S-H>"] = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- close buffer + hide terminal buffer
    ["<leader>lc"] = {
      function()
        require("nvchad.tabufline").close_buffer()
      end,
      "Close buffer",
    },
  },
}


M.nvimtree = {
  plugin = true,
  n = {
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

-- more keybinds!

return M
