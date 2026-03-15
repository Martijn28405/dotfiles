return {
  -- Surround text objects (ys, cs, ds)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Jump anywhere with s/S
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto-close brackets and quotes
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  -- Extended text objects (arguments, quotes, brackets, etc.)
  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = { n_lines = 500 },
  },

  -- Highlight word under cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.keymap.set("n", "]r", function() require("illuminate").goto_next_reference() end, { desc = "Next reference" })
      vim.keymap.set("n", "[r", function() require("illuminate").goto_prev_reference() end, { desc = "Prev reference" })
    end,
  },

  -- Highlight and search TODO/FIXME/HACK/NOTE
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
    },
  },

  -- LSP rename with live preview
  {
    "smjonas/inc-rename.nvim",
    config = function() require("inc_rename").setup() end,
    keys = {
      { "<leader>rn", ":IncRename ", desc = "Rename (live preview)" },
    },
  },

  -- Project-wide search and replace
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", "<cmd>GrugFar<cr>",              desc = "Search and replace" },
      { "<leader>sr", "<cmd>GrugFar<cr>", mode = "v", desc = "Search and replace" },
    },
    opts = {},
  },

  { "nvim-tree/nvim-web-devicons" },
}
