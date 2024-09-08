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
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
    opts = {
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
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        set_env = { ["COLORTERM"] = "truecolor" },
      },
      extensions_list = { "fzf" },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          hidden = true,
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
          go = {
            "gofumpt",
            "golines",
            "goimports_reviser",
          },
          terraform = { "terraform_fmt" },
          ["terraform-vars"] = { "terraform_fmt" },
          bash = { "shfmt" },
          nix = { "nixpkgs_fmt" },
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
        "typescript-language-server",
        "nixpkgs-fmt",
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
        init = function()
          local opts = {} -- Global mappings.
          vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
          vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set(
            "n",
            "<space>wa",
            vim.lsp.buf.add_workspace_folder,
            opts
          )
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
          vim.keymap.set(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            opts
          )
          vim.keymap.set("n", "<leader>gr", function()
            require("telescope.builtin").lsp_references()
          end, opts)
        end,
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
        -- "yamlls",
        "bashls",
        "ts_ls",
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
  -- Disables continuous key press to build better Vim navigation habits
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
  { "nvim-treesitter/nvim-treesitter-context" },
})
