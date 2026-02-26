return {
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  { "echasnovski/mini.indentscope", version = false, opts = {} },
  { "rcarriga/nvim-notify", opts = { stages = "fade" } },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  -- Rainbow colored brackets per nesting depth
  { "HiPhish/rainbow-delimiters.nvim" },

  -- Smooth animations for window open/close/resize
  -- (scroll and cursor disabled — handled by neoscroll + smear-cursor)
  {
    "echasnovski/mini.animate",
    version = false,
    config = function()
      require("mini.animate").setup({
        scroll = { enable = false },
        cursor = { enable = false },
        open = { enable = true },
        close = { enable = true },
        resize = { enable = true },
      })
    end,
  },
}
