return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      format_on_save = false,
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
    },
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
