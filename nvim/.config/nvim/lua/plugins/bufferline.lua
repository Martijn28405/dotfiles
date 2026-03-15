return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant",
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    },
  },

  {
    "echasnovski/mini.bufremove",
    version = false,
    lazy = true,
    opts = {},
    keys = {
      {
        "<leader>bd",
        function() require("mini.bufremove").delete(0, false) end,
        desc = "Delete buffer",
      },
    },
  },
}
