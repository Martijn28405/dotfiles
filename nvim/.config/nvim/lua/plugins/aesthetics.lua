return {
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    opts = {
      window = {
        margin = { horizontal = 1, vertical = 0 },
        padding = 0,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local modified = vim.bo[props.buf].modified and " ●" or ""
        return { " " .. filename .. modified .. " " }
      end,
    },
  },

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
