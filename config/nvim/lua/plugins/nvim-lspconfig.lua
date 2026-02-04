return {
  "neovim/nvim-lspconfig",
  config = function()
    local configs = {
      clangd = {},
      cmake = {},
      gopls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      },
      rust_analyzer = {},
    }

    for server, config in pairs(configs) do
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end

    vim.diagnostic.config({
      virtual_text = false,
      float = { border = "rounded" },
    })

    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end,
    })
  end,
}
