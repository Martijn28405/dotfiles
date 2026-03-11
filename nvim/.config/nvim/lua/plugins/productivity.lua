return {
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { "christoomey/vim-tmux-navigator" },

  -- Makes . repeat work with plugin operations (surround, etc.)
  { "tpope/vim-repeat" },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end,                                        desc = "Harpoon: add file" },
      { "<leader>hh", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end,        desc = "Harpoon: menu" },
      { "<leader>h1", function() require("harpoon"):list():select(1) end,                                   desc = "Harpoon: file 1" },
      { "<leader>h2", function() require("harpoon"):list():select(2) end,                                   desc = "Harpoon: file 2" },
      { "<leader>h3", function() require("harpoon"):list():select(3) end,                                   desc = "Harpoon: file 3" },
      { "<leader>h4", function() require("harpoon"):list():select(4) end,                                   desc = "Harpoon: file 4" },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },

  -- AI agent for Neovim that augments the programmer workflow
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
        provider = _99.Providers.GeminiCLIProvider,
        tmp_dir = "./tmp",
        completion = { source = "cmp" },
      })
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      vim.keymap.set("n", "]r", function()
        require("illuminate").goto_next_reference()
      end, { desc = "Next reference" })
      vim.keymap.set("n", "[r", function()
        require("illuminate").goto_prev_reference()
      end, { desc = "Prev reference" })
    end,
  },

  -- Extended text objects (arguments, quotes, brackets, etc.)
  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = { n_lines = 500 },
  },

  -- Highlight and search TODO/FIXME/HACK/NOTE across the project
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
    config = function()
      require("inc_rename").setup()
    end,
    keys = {
      { "<leader>rn", ":IncRename ", desc = "Rename (live preview)" },
    },
  },

  -- Project-wide search and replace with live preview
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      { "<leader>sr", "<cmd>GrugFar<cr>",              desc = "Search and replace" },
      { "<leader>sr", "<cmd>GrugFar<cr>", mode = "v", desc = "Search and replace" },
    },
    opts = {},
  },
}
