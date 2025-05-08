return {
  "neovim/nvim-lspconfig",
  -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup {
      Lua = {
        format = {
          defaultConfig = {
            indent_size = "2",
          }
        }
      }
    }
  end,
}
