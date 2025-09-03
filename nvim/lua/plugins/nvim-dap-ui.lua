return {
  "rcarriga/nvim-dap-ui",
  lazy = true,
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    {
      "<leader>du",
      function()
        require("dapui").toggle({})
      end,
      desc = "Dap UI",
    },
  },
  config = function(_, opts)
    require("dapui").setup(opts)
  end,
}
