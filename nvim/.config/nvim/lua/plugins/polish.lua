return {
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", event = { "BufReadPost", "BufNewFile" }, opts = {} },
  -- Use "static" to skip the fade animation
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = { stages = "static", timeout = 3000 },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },

  -- Rainbow colored brackets per nesting depth
  { "HiPhish/rainbow-delimiters.nvim", event = { "BufReadPost", "BufNewFile" } },
}
