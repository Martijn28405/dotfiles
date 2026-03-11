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
