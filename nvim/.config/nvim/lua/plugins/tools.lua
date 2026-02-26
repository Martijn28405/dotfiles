return {
  { "nvim-tree/nvim-web-devicons" },

  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  -- Inline color swatches for hex/rgb/hsl/tailwind values
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

  -- Better folding with treesitter/LSP and inline previews
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require("ufo").setup({
        provider_selector = function()
          return { "lsp", "indent" }
        end,
      })

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    end,
  },

  {
    "selimacerbas/markdown-preview.nvim",
    ft = { "markdown", "mmd", "mermaid" },
    dependencies = { "selimacerbas/live-server.nvim" },
    config = function()
      require("markdown_preview").setup({
        open_browser = true,
      })
    end,
  },
}
