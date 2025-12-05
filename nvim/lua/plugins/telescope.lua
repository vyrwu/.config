return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
  },
  init = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", function()
      builtin.find_files({ hidden = true })
    end, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fB", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
    vim.api.nvim_set_keymap(
      "n",
      "<space>fb",
      ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { noremap = true }
    )
  end,
  config = function()
    local fb_actions = require("telescope._extensions.file_browser.actions")
    require("telescope").setup({
      defaults = {
        -- avoid previewing large files
        preview = {
          filesize_limit = 0.1, -- MB
        },
        layout_strategy = "vertical",
        layout_config = {
          -- fullscreen
          vertical = {
            height = { padding = 0 },
            width = { padding = 0 },
            preview_height = 0.6,
          },
        },
        wrap_results = true,
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        file_ignore_patterns = {
          "vendor/",
          "node_modules/",
          ".git/",
        },
        prompt_prefix = "   ",
        -- file_sorter = require("telescope.sorters").get_fuzzy_file,
        -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        borderchars = {
          "─",
          "│",
          "─",
          "│",
          "╭",
          "╮",
          "╯",
          "╰",
        },
        set_env = { ["COLORTERM"] = "truecolor" },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          hidden = true,
          hijack_netrw = false,
        },
      },
    })
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
  end,
}
