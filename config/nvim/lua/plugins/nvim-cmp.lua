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
    local select_opts = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }),

      mapping = {
        ['<c-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<c-n>'] = cmp.mapping.select_next_item(select_opts),
        ['<c-y>'] = cmp.mapping.confirm({ select = true }),

        ['<up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<down>'] = cmp.mapping.select_next_item(select_opts),
        ['<cr>'] = cmp.mapping.confirm({ select = false }),
      },
    })
  end,
}

