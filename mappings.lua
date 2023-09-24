---@type MappingsTable
local M = {}
local fn = vim.fn

M.DAP = {
  n = {
    ["<leader>dc"] = { ":lua require'dap'.continue()<cr>", "Continue", opts = { silent = true } },
    ["<leader>do"] = { ":lua require'dap'.step_over()<cr>", "Step Over", opts = { silent = true } },
    ["<leader>di"] = { ":lua require'dap'.step_into()<cr>", "Step Into", opts = { silent = true } },
    ["<leader>du"] = { ":lua require'dap'.step_out()<cr>", "Step Out", opts = { silent = true } },
    ["<leader>db"] = { ":lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint", opts = { silent = true } },
    ["<leader>dB"] = {
      ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      "Breakpoint Condition",
      opts = { silent = true },
    },
    ["<leader>dd"] = { ":lua require'dapui'.toggle()<cr>", "Dap UI", opts = { silent = true } },
    ["<leader>dl"] = { ":lua require'dap'.run_last()<cr>", "Run Last", opts = { silent = true } },
  },
}

M.Neovim = {
  n = {
    ["<leader>nf"] = {
      function()
        require("telescope.builtin").find_files {
          prompt_title = "Config Files",
          search_dirs = config_dir,
          cwd = cwd,
        }
      end,
      "Find Config Files",
      opts = { silent = true },
    },
    ["<leader>ng"] = {
      function()
        require("telescope.builtin").live_grep {
          prompt_title = "Config Files",
          search_dirs = config_dir,
          cwd = cwd,
        }
      end,
      "Grep Config Files",
      opts = { silent = true },
    },
    ["<leader>nc"] = {
      ":NvCheatsheet<cr>",
      "Cheatsheet",
      opts = { silent = true },
    },
    ["<leader>ni"] = {
      function()
        if vim.fn.has "nvim-0.9.0" == 1 then
          vim.cmd "Inspect"
        else
          vim.notify("Inspect isn't available in this neovim version", vim.log.levels.WARN, { title = "Inspect" })
        end
      end,
      "Inspect",
      opts = { silent = true },
    }, -- only available on neovim >= 0.9
    ["<leader>nu"] = {
      function()
        local args = "git -C " .. vim.fn.stdpath "config" .. " pull --ff-only"
        vim.fn.system(args)
      end,
      "Update",
      opts = { silent = true },
    },
    ["<leader>nm"] = { ":messages<cr>", "Messages", opts = { silent = true } },
    ["<leader>nh"] = { ":checkhealth<cr>", "Health", opts = { silent = true } },
    ["<leader>nv"] = {
      function()
        local version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
        return vim.notify(version, vim.log.levels.INFO, { title = "Neovim Version" })
      end,
      "Version",
      opts = { silent = true },
    },
  },
}

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

    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    [";"] = {
      function()
        if vim.bo.buftype == "terminal" then
          vim.cmd "Bdelete!"
          vim.cmd "silent! close"
        elseif #vim.api.nvim_list_wins() > 1 then
          vim.cmd "silent! close"
        else
          vim.notify("Can't Close Window", vim.log.levels.WARN, { title = "Close Window" })
        end
      end,
      "Close window",
      opts = { silent = true },
    },
    ["<C-Up>"] = {
      ":resize +2<CR>",
      "Add size at the top",
      opts = { silent = true },
    },

    ["<C-Down>"] = {
      ":resize -2<CR>",
      "Add size at the bottom",
      opts = { silent = true },
    },

    ["<C-Left>"] = {
      ":vertical resize +2<CR>",
      "Add size at the left",
      opts = { silent = true },
    },

    ["<C-Right>"] = {
      ":vertical resize -2<CR>",
      "Add size at the right",
      opts = { silent = true },
    },
    ["<S-Tab>"] = {
      ":<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal'})<cr>",
      "Buffers",
      opts = { silent = true },
    },

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
    ["<leader>ol"] = { ":set nu!<cr>", "Toggle line number", opts = { silent = true } },
    ["<leader>or"] = { ":set rnu!<cr>", "Toggle relative number", opts = { silent = true } },
    ["<leader>ot"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "Toggle Transparency",
    },
    ["<leader>m"] = {
      function()
        if vim.bo.filetype == "markdown" then
          vim.cmd "MarkdownPreviewToggle"
        else
          vim.notify("Only available in markdown", vim.log.levels.WARN, { title = "Markdown-Preview" })
        end
      end,
      "Markdown Preview",
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
  t = {
    ["<Esc>"] = {
      "<C-\\><C-n>",
      "Enter insert mode",
      opts = { silent = true, noremap = true },
    },
    ["<C-h>"] = {
      "<C-\\><C-n><C-W>h",
      "Leave terminal",
      opts = { silent = true, noremap = true },
    },
    ["<C-j>"] = {
      "<C-\\><C-n><C-W>j",
      "Leave terminal",
      opts = { silent = true, noremap = true },
    },
    ["<C-k>"] = {
      "<C-\\><C-n><C-W>k",
      "Leave terminal",
      opts = { silent = true, noremap = true },
    },
    ["<C-l>"] = {
      "<C-\\><C-n><C-W>l",
      "Leave terminal",
      opts = { silent = true, noremap = true },
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
-- M.LSP = {
-- n = {
--   ["<leader>lf"] = {
--     function()
--       vim.lsp.buf.format { async = true }
--     end,
--     "LSP formatting",
--   },

--   ["<leader>lr"] = {
--     function()
--       require("nvchad.renamer").open()
--     end,
--     "LSP rename",
--   },
-- },
-- }
M.LSP = {
  n = {
    ["<leader>lf"] = { ":Format<cr>", "Format", opts = { silent = true } },
    ["<leader>la"] = { ":Lspsaga code_action<cr>", "Code Action", opts = { silent = true } },
    ["<leader>li"] = { ":LspInfo<cr>", "Info", opts = { silent = true } },
    ["<leader>lo"] = { ":Lspsaga outline<cr>", "Code Outline", opts = { silent = true } },
    ["<leader>lI"] = { ":Lspsaga incoming_calls<cr>", "Incoming Calls", opts = { silent = true } },
    ["<leader>lO"] = { ":Lspsaga outgoing_calls<cr>", "Outgoing Calls", opts = { silent = true } },
    ["<leader>lm"] = { ":Mason<cr>", "Mason Installer", opts = { silent = true } },
    ["<leader>lj"] = {
      ":Lspsaga diagnostic_jump_next<cr>",
      "Next Diagnostic",
      opts = { silent = true },
    },
    ["<leader>lk"] = {
      ":Lspsaga diagnostic_jump_prev<cr>",
      "Prev Diagnostic",
      opts = { silent = true },
    },
    ["<leader>lR"] = { ":LspRestart<cr>", "Restart", opts = { silent = true } },
    ["<leader>lr"] = { ":Lspsaga rename<cr>", "Rename", opts = { silent = true } },
    ["<leader>ld"] = { ":Telescope diagnostics bufnr=0<cr>", "Buffer Diagnostics", opts = { silent = true } },
    ["<leader>lw"] = { ":Telescope diagnostics<cr>", "Workspace Diagnostics", opts = { silent = true } },
    ["<leader>ls"] = { ":Telescope lsp_document_symbols<cr>", "Buffer Symbols", opts = { silent = true } },
    ["<leader>lS"] = { ":Telescope lsp_workspace_symbols<cr>", "Workspace Symbols", opts = { silent = true } },
  },
  v = {
    ["<leader>la"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "Code Action",
    },
  },
}
M.Git = {
  n = {
    ["<leader>gg"] = {
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
        lazygit:toggle()
      end,
      "Lazygit",
      opts = { silent = true },
    },
    ["<leader>gj"] = { ":lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk", opts = { silent = true } },
    ["<leader>gk"] = { ":lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk", opts = { silent = true } },
    ["<leader>gl"] = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame", opts = { silent = true } },
    ["<leader>gp"] = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk", opts = { silent = true } },
    ["<leader>gr"] = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk", opts = { silent = true } },
    ["<leader>gR"] = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer", opts = { silent = true } },
    ["<leader>gs"] = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk", opts = { silent = true } },
    ["<leader>gu"] = { ":lua reguire 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stgge Hunk", opts = { silent = true } },
    ["<leader>go"] = { ":Telescope git_status<cr>", "Open changed file", opts = { silent = true } },
    ["<leader>gb"] = { ":Telescope git_branches<cr>", "Checkout branch", opts = { silent = true } },
    ["<leader>gc"] = { ":Telescope git_commits<cr>", "Checkout commit", opts = { silent = true } },
    ["<leader>gd"] = {
      function()
        if next(require("diffview.lib").views) == nil then
          vim.cmd "DiffviewOpen"
        else
          vim.cmd "DiffviewClose"
        end
      end,
      "Toggle Diffview",
      opts = { silent = true },
    },
  },
}

if vim.lsp.inlay_hint then
  M.LSP.n["<leader>lh"] = { ":lua vim.lsp.inlay_hint(0, nil)<cr>", "Inlay Hint", opts = { silent = true } }
end

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
    ["<leader>c"] = {
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
    ["<C-n>"] = {
      function()
        -- vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
        local api = require "nvim-tree.api"
        api.node.open.vertical()
      end,
      "Open: Vertical Split ",
    },
  },
}

M.disabled = {
  n = {
    ["<Up>"] = "",
    ["<Down>"] = "",
    ["<tab>"] = "",
    ["<S-tab>"] = "",

    ["<Esc>"] = "",
    ["<C-c>"] = "",
    ["<C-s>"] = "",
    ["<C-v>"] = "",
    ["<C-n>"] = "",

    ["<A-i>"] = "",
    ["<A-h>"] = "",
    ["<A-v>"] = "",

    ["<leader>x"] = "",
    ["<leader>v"] = "",

    ["gD"] = "",
    ["gd"] = "",
    ["K"] = "",
    ["gi"] = "",
  },
}

-- more keybinds!

return M
