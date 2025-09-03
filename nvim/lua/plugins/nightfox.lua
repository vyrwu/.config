return {
  "EdenEast/nightfox.nvim",
  opts = {
    options = {
      transparent = true,
      styles = {
        comments = "italic",
      },
    },
  },
  config = function(_, opts)
    require("nightfox").setup(opts)
    dark = "nordfox"
    light = "dayfox"
    vim.cmd(string.format("colorscheme %s", dark))
    -- colorcheme switch
    vim.keymap.set("n", "<leader>cs", function()
      if vim.g.colors_name == dark then
        vim.cmd(string.format("colorscheme %s", light))
        return
      end
      vim.cmd(string.format("colorscheme %s", dark))
    end)
  end,
}
