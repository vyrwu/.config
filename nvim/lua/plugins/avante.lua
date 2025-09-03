return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  opts = {
    provider = "gemini",
    providers = {
      gemini = {
        mode = "agentic",
        model = "gemini-2.5-flash",
        timeout = 10000,
        disabled_tools = {
          "git_diff",
          "glob",
          "search_keyword",
          "read_file_toplevel_symbols",
          "read_file",
          "web_search",
          "fetch",
          -- "replace_in_file"
          -- "rag_search",
          -- "git_commit",
          -- "python",
          -- "create_file",
          -- "move_path",
          -- "copy_path",
          -- "delete_path",
          -- "create_dir",
          -- "bash",
        },
        extra_request_body = {
          generationConfig = {
            temperature = 0.75,
          },
        },
      },
    },
    web_search_engine = {
      provider = "google",
      proxy = nil,
    },
    rules = {
      -- system prompts
      global_dir = "~/.config/avante/rules",
    },
    windows = {
      wrap = true,
      width = 100,
      ask = {
        start_insert = false,
      },
    },
  },
}
