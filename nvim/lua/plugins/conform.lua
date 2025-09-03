return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform").setup({
      -- Nvim Filetypes:
      -- https://github.com/nathom/filetype.nvim/blob/main/lua/filetype/mappings/extensions.lua
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format", "ruff_optimize_imports" },
        xml = { "xmlformat" },
        go = {
          "gofumpt",
          -- "golines",
          "goimports_reviser",
        },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        bash = { "shfmt" },
        nix = { "nixfmt" },
        templ = { "templ" },
        cs = { "csharpier" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = "fallback",
      },
    })
  end,
}
