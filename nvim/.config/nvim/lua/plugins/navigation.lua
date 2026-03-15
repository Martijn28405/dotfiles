return {
  -- Telescope fzf-native (voor snellere fuzzy finding)
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      pcall(require("telescope").load_extension, "fzf")
    end,
  },

  -- Treesitter context (code context bovenaan, zoals in IDE's)
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

  -- File explorer sidebar (neo-tree)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- of nvim-web-devicons als je die al hebt
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
          },
        },
      })
    end,
  },

  -- Bufferline (tabs bovenaan zoals in IDE's)
  {
    "akinsho/bufferline.nvim",
    version = "*", -- gebruik latest stable
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "slant",
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,          -- ← dit is de key: altijd tonen, zelfs met 1 buffer
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      },
    },
  },
})
    end,
  },
}
