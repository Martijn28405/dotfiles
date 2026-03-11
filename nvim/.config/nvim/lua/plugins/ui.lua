return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },

  -- Buffer tabs at the top
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
      },
    },
    keys = {
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete buffer",
      },
    },
  },

  {
    "echasnovski/mini.bufremove",
    version = false,
    lazy = true,
    opts = {},
  },

  -- LSP progress spinner
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = { winblend = 0 },
      },
    },
  },

  -- Better vim.ui.select and vim.ui.input
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },

  -- Breadcrumbs in the winbar (file > class > function)
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Better quickfix list workflow
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {},
  },
}
