return {
  { "nvim-tree/nvim-web-devicons" },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust", "go", "bash" },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },

  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
}

