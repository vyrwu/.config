return {
  "numToStr/Comment.nvim",
  config = function()
    vim.keymap.set("n", "<leader>/", function()
      require("Comment.api").toggle.linewise()
    end, {})
    vim.keymap.set(
      "v",
      "<leader>/",
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      {}
    )
  end,
}
