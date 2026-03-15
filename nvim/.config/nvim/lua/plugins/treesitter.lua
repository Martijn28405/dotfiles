return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      auto_install = true,
      ensure_installed = {
        "astro",
        "bash",
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "yaml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- Sticky function/class context at top of buffer
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
