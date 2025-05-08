return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  keys = {
    { "<leader>gsN", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous hunk" },
    { "<leader>gsn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
    { "<leader>gsp", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview hunk" },
  },
}

