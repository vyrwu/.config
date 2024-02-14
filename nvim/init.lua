-- set indentation
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

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

-- disable arrow keys
vim.keymap.set(
  "",
  "<Left>",
  '<cmd>echo "ᕙ(⇀‸↼‶)ᕗ h, not Left!"<CR>',
  { noremap = true }
)
vim.keymap.set(
  "",
  "<Right>",
  '<cmd>echo "ᕙ(⇀‸↼‶)ᕗ l, not Right!"<CR>',
  { noremap = true }
)
vim.keymap.set(
  "",
  "<Up>",
  '<cmd>echo "ᕙ(⇀‸↼‶)ᕗ k, not Up!"<CR>',
  { noremap = true }
)
vim.keymap.set(
  "",
  "<Down>",
  '<cmd>echo "ᕙ(⇀‸↼‶)ᕗ j, not Down!"<CR>',
  { noremap = true }
)

vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true })

-- indent while remaining in visual mode
vim.keymap.set("v", ">", ">gv", { noremap = true })
vim.keymap.set("v", "<", "<gv", { noremap = true })

-- dismiss search highlights
vim.keymap.set("n", "<C-c>", "<cmd> noh <CR>", {})

-- set system clipboard to vim register
vim.opt.clipboard = "unnamedplus"

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

require("lazy").setup({
  { "tpope/vim-sensible", lazy = false },
  {
    "nvim-telescope/telescope.nvim",
    commit = "057ee0f8783872635bc9bc9249a4448da9f99123",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    init = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end,
    opts = {
      defaults = {
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
          ".terraform/",
        },
        prompt_prefix = "   ",
        -- file_sorter = require("telescope.sorters").get_fuzzy_file,
        -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        set_env = { ["COLORTERM"] = "truecolor" },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      },

      extensions_list = { "fzf" },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    init = function()
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
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
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
    init = function()
      vim.keymap.set({ "n", "v" }, "<leader>fmt", function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end, {})
    end,
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
          python = { "black" },
          go = { "gofumpt", "golines", "goimports_reviser" },
          terraform = { "terraform_fmt" },
          ["terraform-vars"] = { "terraform_fmt" },
          bash = { "shfmt" },
          ["*"] = { "codespell" },
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = {
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "golangci-lint",
        "gopls",
        "terraform-ls",
        "tflint",
        "helm-ls",
        "yaml-language-server",
        "yamllint",
        "json-lsp",
        "marksman", --markdown
        "bash-language-server",
        "eslint_d",
        "pylint",
        "actionlint",
        "black",
        "codespell",
        "gofumpt",
        "goimports-reviser",
        "golines",
        "shfmt",
        "prerrierd",
      },
      automatic_installation = true,
      max_concurrent_installers = 10,
    },
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
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- helm_ls
      { "towolf/vim-helm", lazy = false },
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
        "yamlls",
        "bashls",
      }

      for _, v in pairs(lsps) do
        if v == "gopls" then
          lspconfig[v].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
              gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                  unusedarams = true,
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
        yaml = { "actionlint" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "pylint" },
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
})
