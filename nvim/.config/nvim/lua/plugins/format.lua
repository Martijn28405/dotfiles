return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return {
        format_on_save = function()
          if not vim.g.autoformat_enabled then
            return
          end
          return { timeout_ms = 2000, lsp_fallback = true }
        end,
        formatters_by_ft = {
          ["*"] = { "trim_whitespace", "trim_newlines" },
          ["_"] = {},
          python = { "isort", "black" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          markdown = { "prettier" },
          yaml = { "prettier" },
        },
      }
    end,
  },

  { "williamboman/mason.nvim", opts = {} },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "black", "isort", "prettier", "ruff", "eslint_d", "selene" },
      run_on_start = true,
    },
  },
}
