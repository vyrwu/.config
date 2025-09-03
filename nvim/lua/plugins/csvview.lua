return {
  "hat0uma/csvview.nvim",
  opts = {
    parser = { comments = { "#", "//" } },
    keymaps = {
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
    },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  keys = {
    { "<leader>cv", vim.cmd.CsvViewToggle },
  },
}
