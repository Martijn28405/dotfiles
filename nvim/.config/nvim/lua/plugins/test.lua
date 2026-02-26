return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-go",
    },
    keys = {
      { "<leader>nr", function() require("neotest").run.run() end,                            desc = "Run nearest test" },
      { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end,          desc = "Run test file" },
      { "<leader>ns", function() require("neotest").summary.toggle() end,                     desc = "Test summary" },
      { "<leader>no", function() require("neotest").output_panel.toggle() end,                desc = "Test output" },
      { "<leader>nd", function() require("neotest").run.run({ strategy = "dap" }) end,        desc = "Debug nearest test" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({ dap = { justMyCode = false } }),
          require("neotest-jest"),
          require("neotest-go"),
        },
      })
    end,
  },
}
