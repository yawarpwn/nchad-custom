local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local util = require "lspconfig.util"

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers =
  { "html", "cssls", "tsserver", "clangd", "tailwindcss", "denols", "astro", "jsonls", "sqlls", "eslint" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


-- lspconfig.pyright.setup { blabla}
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
lspconfig.jsonls.setup {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.denols.setup {
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true,
        },
      },
    },
  },
}


lspconfig.tsserver.setup {
  root_dir = util.root_pattern("package.json"),
  single_file_support = false
}
