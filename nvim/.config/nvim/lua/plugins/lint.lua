return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    config = function()
      local lint = require("lint")
      local lint_events = { "BufWritePost", "BufReadPost", "InsertLeave" }

      lint.linters_by_ft = {
        python = { "ruff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        lua = { "selene" },
        php = { "phpcs" },
      }

      -- Run linter automatically on the events above
      vim.api.nvim_create_autocmd(lint_events, {
        callback = function()
          lint.try_lint()
        end,
      })

      -- Manual trigger
      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Lint current file" })
    end,
  },
}
