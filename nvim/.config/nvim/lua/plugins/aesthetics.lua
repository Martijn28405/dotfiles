return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      chunk = { enable = true },
      indent = { enable = false },
      line_num = { enable = false },
      blank = { enable = false },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      heading = {
        enabled = true,
        sign = false,
      },
    },
  },
}
