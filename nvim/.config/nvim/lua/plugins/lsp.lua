return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,                   opts)
        vim.keymap.set("n", "K",  vim.lsp.buf.hover,                        opts)
        vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>",      opts)
        vim.keymap.set("n", "gD", "<cmd>Glance definitions<cr>",            opts)
        vim.keymap.set("n", "gR", "<cmd>Glance references<cr>",             opts)
        vim.keymap.set("n", "gI", "<cmd>Glance implementations<cr>",        opts)
        vim.keymap.set("n", "gY", "<cmd>Glance type_definitions<cr>",       opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,                 opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next,                 opts)
      end

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "pyright",
          "rust_analyzer",
          "intelephense",
          "csharp_ls",
          "volar",
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

  -- Peek definitions/references in a float without leaving current file
  {
    "dnlhc/glance.nvim",
    opts = {},
  },
}
