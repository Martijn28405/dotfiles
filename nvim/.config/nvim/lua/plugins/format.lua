return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Autoformat toggle (was config/format.lua)
      vim.g.autoformat_enabled = false

      vim.api.nvim_create_user_command("FormatToggle", function()
        vim.g.autoformat_enabled = not vim.g.autoformat_enabled
        local state = vim.g.autoformat_enabled and "ON" or "OFF"
        vim.notify("Format on save: " .. state, vim.log.levels.INFO)
      end, { desc = "Toggle format on save" })

      vim.keymap.set("n", "<leader>uf", "<cmd>FormatToggle<cr>", {
        noremap = true, silent = true, desc = "Toggle format on save",
      })

      require("conform").setup({
        format_on_save = function()
          if vim.g.autoformat_enabled == false then return end
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
      })
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
