return {
  -- Shows available keybindings in a popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
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

  -- Breadcrumbs in the winbar
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Better quickfix list
  { "stevearc/quicker.nvim", ft = "qf", opts = {} },

  -- Indent guide lines
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", event = { "BufReadPost", "BufNewFile" }, opts = {} },

  -- Rainbow colored brackets
  { "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPost", "BufNewFile" } },

  -- Inline color swatches for hex/rgb/hsl/tailwind
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      user_default_options = {
        css = true,
        tailwind = true,
      },
    },
  },

  -- Rendered markdown in-buffer
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      bullet = { enabled = true, icons = { "●", "○", "◆", "◇" } },
      heading = { enabled = true, sign = false },
    },
  },

  -- Markdown preview in browser
  {
    "selimacerbas/markdown-preview.nvim",
    ft = { "markdown", "mmd", "mermaid" },
    dependencies = { "selimacerbas/live-server.nvim" },
    config = function()
      require("markdown_preview").setup({ open_browser = true })
    end,
  },
}
