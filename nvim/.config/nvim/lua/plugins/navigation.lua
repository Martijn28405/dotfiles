return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      pcall(require("telescope").load_extension, "fzf")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 3,
      multiline_threshold = 8,
    },
    keys = {
      {
        "<leader>tc",
        function()
          local ok, ts_context = pcall(require, "treesitter-context")
          if ok then
            ts_context.toggle()
          else
            vim.notify("treesitter-context niet geladen. Run :Lazy sync", vim.log.levels.WARN)
          end
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },

}
