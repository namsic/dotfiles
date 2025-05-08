return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({})
        end,
      },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
