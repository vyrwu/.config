return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "go",
        "gosum",
        "gomod",
        "markdown",
        "markdown_inline",
        "terraform",
        "yaml",
        "json",
        "bash",
        "regex",
        "nix",
        "just",
        "html",
        "templ",
        "c_sharp",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
