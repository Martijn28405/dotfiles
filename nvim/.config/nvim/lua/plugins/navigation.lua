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

  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = {
        min_width = 28,
        default_direction = "right",
      },
    },
    keys = {
      { "<leader>as", "<cmd>AerialToggle!<cr>", desc = "Aerial symbols" },
      { "]s", "<cmd>AerialNext<cr>", desc = "Next symbol" },
      { "[s", "<cmd>AerialPrev<cr>", desc = "Prev symbol" },
    },
  },
}
