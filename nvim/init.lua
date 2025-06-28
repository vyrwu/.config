vim.lsp.set_log_level("off")

-- set indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- set numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.colorcolumn = "80"

-- match terminal theme with nvim
vim.opt.termguicolors = true

-- indent while remaining in visual mode
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })

-- dismiss search highlights
vim.keymap.set("n", "<C-c>", "<cmd> noh <CR>", {})

-- base64 encode selected text
vim.keymap.set("v", "<leader>64", "c<c-r>=system('base64', @\")<cr><esc>")

-- base64 decode selected text
vim.keymap.set(
  "v",
  "<leader>d64",
  "c<c-r>=system('base64 --decode', @\")<cr><esc>"
)

-- save buffer on :W as well as :w
vim.api.nvim_create_user_command(
  "W",
  "<line1>,<line2>write<bang>",
  { bang, range = "%", complete = "file", nargs = "*" }
)

-- set system clipboard to vim register
vim.opt.clipboard = "unnamedplus"

-- offset cursor position by minimum 10 lines up/down
vim.opt.scrolloff = 999

vim.opt.list = true
vim.opt.listchars = {
  -- eol = "↵",
  -- space = "~",
  trail = "~",
  tab = ">-",
  nbsp = "␣",
}

-- set global status line (recommended for avante.nvim)
-- Ref: https://github.com/yetone/avante.nvim/blob/2ead26f809dd9804678de3dd18fa65ab3fadce29/README.md?plain=1#L201
vim.opt.laststatus = 3

-- setup lazyvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- NOTE REGARDING LAZY LOADING OF PLUGINS
-- the init property runs before the plugin is lazy loaded
-- the config property runs when the plugin gets loaded
-- if the plugin does not explicitly define lazy loading, it is always loaded
require("lazy").setup({
  { "tpope/vim-sensible", lazy = false },
  {
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
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              height = 0.95,
              width = 0.95,
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
            hijack_netrw = true,
          },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },
  {
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
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme nordfox")
    end,
  },
  {
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
  },
  {
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
          ["*"] = function(bufnr)
            local bufname = vim.api.nvim_buf_get_name(bufnr)

            -- Disable formatting on Templ-generated files
            if bufname:match("_templ") then
              return
              -- else
              --   return { "codespell" }
            end
            return {}
          end,
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = {
          timeout_ms = 5000,
          lsp_format = "fallback",
        },
      })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    -- optional for floating window border decoration
    init = function()
      vim.keymap.set({ "n", "v" }, "<leader>gg", vim.cmd.LazyGit, {})
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", vim.cmd.LazyGit, desc = "Open LazyGit." },
    },
  },
  { "LnL7/vim-nix", ft = "nix" },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- helm_ls
      { "towolf/vim-helm", lazy = false },
      -- omnisharp extended actions to fix go_to_definition
      -- ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#omnisharp
      { "Hoffs/omnisharp-extended-lsp.nvim", lazy = false },
      -- completion
      {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
          "hrsh7th/cmp-cmdline",
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-buffer",
          "hrsh7th/cmp-path",
        },
        config = function()
          local cmp = require("cmp")
          cmp.setup({
            mapping = cmp.mapping.preset.insert({
              ["<C-u>"] = cmp.mapping.scroll_docs(-4),
              ["<C-d>"] = cmp.mapping.scroll_docs(4),
              ["<C-c>"] = cmp.mapping.abort(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "vsnip" },
              { name = "buffer" },
            }),
          })
        end,
      },
    },
    init = function()
      -- global LSP actions
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set(
        "n",
        "<space>wr",
        vim.lsp.buf.remove_workspace_folder,
        opts
      )
      vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>gr", function()
        require("telescope.builtin").lsp_references()
      end, opts)
    end,
    config = function()
      local on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local lspconfig = require("lspconfig")
      local util = require("lspconfig/util")

      local lsps = {
        "gopls",
        "terraformls",
        "helm_ls",
        "jsonls",
        -- "yamlls",
        "bashls",
        "ts_ls",
        "pyright",
        "nil_ls",
        "htmx",
        "tailwindcss",
        "html",
        "templ",
        "omnisharp",
      }

      for _, v in pairs(lsps) do
        if v == "gopls" then
          capabilities.workspace.didChangeWatchedFiles.dynamicRegistration =
            true
          capabilities.workspace.workspaceFolders = true
          lspconfig[v].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
              gopls = {
                buildFlags = { "-tags=e2e" },
                completeUnimported = true,
                usePlaceholders = true,
                staticcheck = true,
                gofumpt = true,
                analyses = {
                  unusedparams = true,
                },
              },
            },
          })
          goto continue
        end

        if v == "helm_ls" then
          lspconfig[v].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "helm_ls", "serve" },
            filetypes = { "helm" },
            root_dir = util.root_pattern("Chart.yaml"),
          })
          goto continue
        end

        if v == "pyright" then
          lspconfig[v].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "python" },
          })
          goto continue
        end

        if v == "omnisharp" then
          lspconfig[v].setup({
            on_attach = function(client, bufnr)
              -- extended code actions from "Hoffs/omnisharp-extended-lsp.nvim"
              -- that make go_to_definiton work
              extended = require("omnisharp_extended")
              vim.keymap.set("n", "gd", extended.lsp_definition)
              vim.keymap.set("n", "<leader>D", extended.lsp_type_definition)
              vim.keymap.set("n", "<leader>gr", extended.lsp_references)
              vim.keymap.set("n", "gi", extended.lsp_implementation)
              on_attach(client, bufnr)
            end,
            capabilities = capabilities,
            cmd = { "omnisharp" },
          })

          goto continue
        end

        lspconfig[v].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })

        ::continue::
      end
    end,
  },
  { "airblade/vim-gitgutter" },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        -- yaml = { "actionlint" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        -- python = { "pylint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          group = lint_augroup,
          callback = function()
            lint.try_lint()
          end,
        }
      )

      vim.keymap.set({ "n" }, "<leader>li", function()
        lint.try_lint()
      end, { desc = "Trigger lint for file" })
    end,
  },
  -- Disables continuous key press to build better Vim navigation habits
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
  { "nvim-treesitter/nvim-treesitter-context" },
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = "*",
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
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
      windows = {
        width = 40,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
      },
      {
        "<leader>dT",
        function()
          require("dap").terminate()
        end,
      },
      {
        "<leader>dj",
        function()
          require("dap").step_into()
        end,
      },
      {
        "<leader>dl",
        function()
          require("dap").step_over()
        end,
      },
      {
        "<leader>dh",
        function()
          require("dap").step_back()
        end,
      },
    },
  },

  {
    "leoluz/nvim-dap-go",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    keys = {
      {
        "<leader>dt",
        function()
          require("dap-go").debug_test()
        end,
        desc = "Debug test",
      },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
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
  },
})
