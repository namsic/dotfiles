return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }),

      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      }),
    })
  end,
}

