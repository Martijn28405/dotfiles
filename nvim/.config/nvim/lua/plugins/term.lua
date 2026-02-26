return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "float",
      open_mapping = [[<c-\>]],
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
  },
}
