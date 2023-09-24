local conform = require "conform"

local prettier_ft = {
  -- "angular",
  "css",
  -- "flow",
  -- "graphql",
  "html",
  "json",
  "jsx",
  "javascript",
  "javascriptreact",
  -- "less",
  "markdown",
  -- "scss",
  "typescript",
  -- "vue",
  "yaml",
}


local formatters_by_ft = {}
for _, filetype in pairs(prettier_ft) do
  formatters_by_ft[filetype] = { "prettier" }
end

local others  = {
  lua = { "stylua" },
  -- Puedes agregar más configuraciones de formateadores aquí para otros tipos de archivo
  -- python = { "autopep8" },
  -- cpp = { "clang_format" },
  -- c = { "clang_format" },
  -- go = { "gofumpt" },
}

local formatters_by_ft = vim.tbl_deep_extend("force", formatters_by_ft, others)


conform.setup {
  formatters_by_ft = formatters_by_ft,
}


