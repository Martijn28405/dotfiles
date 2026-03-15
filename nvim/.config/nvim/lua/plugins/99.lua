return {
  {
    "ThePrimeagen/99",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>9p", function() require("99.extensions.telescope").select_provider() end, desc = "99: select provider" },
      { "<leader>9m", function() require("99.extensions.telescope").select_model() end,    desc = "99: select model" },
      { "<leader>9w", function() require("99").vibe() end,                                 desc = "99: vibe (agentic)" },
      { "<leader>9v", function() require("99").visual() end,                               desc = "99: visual replace", mode = "v" },
      { "<leader>9s", function() require("99").search() end,                               desc = "99: search" },
      { "<leader>9o", function() require("99").open() end,                                 desc = "99: history" },
      { "<leader>9x", function() require("99").stop_all_requests() end,                    desc = "99: stop all" },
    },
    config = function()
      local _99 = require("99")
      _99.setup({
        provider = _99.Providers.ClaudeCodeProvider,
        tmp_dir = "./tmp",
        completion = { source = "cmp" },
      })
    end,
  },
}
