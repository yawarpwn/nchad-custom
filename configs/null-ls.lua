local null_ls = require "null-ls"

local b = null_ls.builtins
local sources = {

  -- webdev stuff
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  -- b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
  b.formatting.prettier.with {
    extra_filetypes = { "astro" },
  }, -- so prettier works only on these filetypes
  -- b.formatting.prettierd.with({
  --   extra_filetypes = { "astro"}
  -- }), -- so prettier works only on these filetypes
  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
  b.diagnostics.eslint.with {
    command = "eslint_d",
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}
