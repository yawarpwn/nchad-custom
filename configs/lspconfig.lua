local on_attach = require("custom.configs.lsp").on_attach
local capabilities = require("custom.configs.lsp").capabilities

local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local config = {
  -- Enable virtual text
  virtual_text = true,
  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

local mason_lspconfig = require "mason-lspconfig"

local disabled_servers = {
  "jdtls",
}

mason_lspconfig.setup_handlers {
  function(server_name)
    for _, name in pairs(disabled_servers) do
      if name == server_name then
        return
      end
    end
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    local require_ok, server = pcall(require, "custom.configs.lsp.settings." .. server_name)
    if require_ok then
      opts = vim.tbl_deep_extend("force", server, opts)
    end

    require("lspconfig")[server_name].setup(opts)
  end,
}

-- local lspconfig = require "lspconfig"

-- -- if you just want default config for the servers then put them in a table
-- local servers =
--   { "html", "cssls", "tsserver", "clangd", "tailwindcss", "denols", "astro", "jsonls", "sqlls", "eslint" }

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end


-- -- lspconfig.pyright.setup { blabla}
-- -- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- lspconfig.jsonls.setup {
--   settings = {
--     json = {
--       schemas = require("schemastore").json.schemas(),
--       validate = { enable = true },
--     },
--   },
-- }

-- lspconfig.denols.setup {
--   root_dir = util.root_pattern("deno.json", "deno.jsonc"),
--   init_options = {
--     lint = true,
--     unstable = true,
--     suggest = {
--       imports = {
--         hosts = {
--           ["https://deno.land"] = true,
--           ["https://cdn.nest.land"] = true,
--           ["https://crux.land"] = true,
--         },
--       },
--     },
--   },
-- }


-- lspconfig.tsserver.setup {
--   root_dir = util.root_pattern("package.json"),
--   single_file_support = false
-- }
