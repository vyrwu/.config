return {
  "kdheepak/lazygit.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", vim.cmd.LazyGit, desc = "Open LazyGit." },
  },
  init = function()
    vim.g.lazygit_floating_window_scaling_factor = 1
  end,
}
