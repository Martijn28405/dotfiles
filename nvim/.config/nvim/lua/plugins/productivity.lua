return {
  {
    "kylechui/nvim-surround",
    version = "*",
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

  -- Distraction-free writing/reading mode
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen mode" },
    },
    opts = {
      plugins = {
        twilight = { enabled = true },
      },
    },
  },

  -- Dims inactive code outside the current context (pairs with zen-mode)
  { "folke/twilight.nvim", opts = {} },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      local map = vim.keymap.set
      map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: add file" })
      map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: menu" })
      map("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon: file 1" })
      map("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon: file 2" })
      map("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon: file 3" })
      map("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon: file 4" })
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

  -- Enhanced increment/decrement: dates, booleans, hex, const/let, etc.
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end },
      { "<C-a>", function() require("dial.map").manipulate("increment", "visual") end, mode = "v" },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end, mode = "v" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({
            elements = { "let", "const" },
            word = true,
            cyclic = true,
          }),
        },
      })
    end,
  },

  -- Split/join code blocks intelligently (function args, arrays, objects)
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>j", function() require("treesj").toggle() end, desc = "Split/join block" },
    },
    opts = { use_default_keymaps = false },
  },

  -- Extended text objects (arguments, quotes, brackets, etc.)
  {
    "echasnovski/mini.ai",
    version = false,
    opts = { n_lines = 500 },
  },

  -- Yank history — cycle through past yanks after pasting
  {
    "gbprod/yanky.nvim",
    opts = {},
    keys = {
      { "p",     "<Plug>(YankyPutAfter)",    mode = { "n", "x" } },
      { "P",     "<Plug>(YankyPutBefore)",   mode = { "n", "x" } },
      { "<C-p>", "<Plug>(YankyCycleForward)",  desc = "Cycle yank forward" },
      { "<C-n>", "<Plug>(YankyCycleBackward)", desc = "Cycle yank backward" },
    },
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
