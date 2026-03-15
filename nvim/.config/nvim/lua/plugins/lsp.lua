return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gd",          vim.lsp.buf.definition,       opts)
        vim.keymap.set("n", "K",           vim.lsp.buf.hover,            opts)
        vim.keymap.set("n", "[d",          vim.diagnostic.goto_prev,     opts)
        vim.keymap.set("n", "]d",          vim.diagnostic.goto_next,     opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))
        vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float,    vim.tbl_extend("force", opts, { desc = "Diagnostic float" }))
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action,      vim.tbl_extend("force", opts, { desc = "Code action" }))
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references,       vim.tbl_extend("force", opts, { desc = "References" }))
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename,           vim.tbl_extend("force", opts, { desc = "Rename" }))
      end

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "pyright",
          "rust_analyzer",
          "intelephense",
          "vue_ls",
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                },
              },
            })
          end,
          intelephense = function()
            require("lspconfig").intelephense.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              single_file_support = true,
              root_dir = function(fname)
                return require("lspconfig.util").root_pattern("composer.json", ".git")(fname)
                  or vim.fs.dirname(vim.fs.find("composer.json", { path = fname, upward = true })[1] or fname)
                  or vim.fn.getcwd()
              end,
            })
          end,
        },
      })
    end,
  },
}
