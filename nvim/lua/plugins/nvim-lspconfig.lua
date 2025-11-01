return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- helm_ls
    { "towolf/vim-helm", lazy = false },
    -- omnisharp extended actions to fix go_to_definition
    -- ref: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#omnisharp
    { "Hoffs/omnisharp-extended-lsp.nvim", lazy = false },
  },
  init = function() end,
  config = function()
    -- LSP Actions
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
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>gr", function()
      require("telescope.builtin").lsp_references()
    end, opts)

    --- Server Configuration
    local on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local util = require("lspconfig/util")
    local getDefault = function()
      return {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end

    local config = {
      lua_ls = getDefault,
      pyright = getDefault,
      terraformls = getDefault,
      jsonls = getDefault,
      yamlls = getDefault,
      bashls = getDefault,
      ts_ls = getDefault,
      nil_ls = getDefault,
      htmx = getDefault,
      tailwindcss = getDefault,
      html = getDefault,
      templ = getDefault,
      gopls = function()
        capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
        capabilities.workspace.workspaceFolders = true
        return {
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
        }
      end,
      helm_ls = function()
        return {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = { "helm_ls", "serve" },
          filetypes = { "helm" },
          root_dir = util.root_pattern("Chart.yaml"),
        }
      end,
      omnisharp = function()
        return {
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
        }
      end,
    }

    for server, getConfig in pairs(config) do
      vim.lsp.config(server, getConfig())
      vim.lsp.enable(server)
    end
  end,
}
