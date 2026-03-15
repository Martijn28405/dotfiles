return {
  {
    "neovim/nvim-lspconfig",
    -- Not lazy-loaded: lspconfig must register its FileType autocmds before
    -- any buffer opens. Lazy-loading causes a race with Telescope (and other
    -- openers) where FileType fires before the handlers are registered.
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Diagnostics config (was config/diagnostics.lua)
      vim.diagnostic.config({
        virtual_text = {
          spacing = 2,
          prefix = "●",
          severity = { min = vim.diagnostic.severity.WARN },
          source = "if_many",
        },
        signs = true,
        underline = true,
        severity_sort = true,
        update_in_insert = false,
        float = { border = "rounded", source = "if_many" },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,                   opts)
        vim.keymap.set("n", "K",  vim.lsp.buf.hover,                        opts)
        vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>",      opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,                 opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next,                 opts)
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

  -- Function signature hint while typing arguments
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    opts = {
      bind = true,
      handler_opts = { border = "rounded" },
    },
  },

  -- Peek definitions/references/implementations in an inline float
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    opts = {},
  },
}
