return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          map("n", "]h", gs.next_hunk,                                    "Next hunk")
          map("n", "[h", gs.prev_hunk,                                    "Prev hunk")
          map("n", "<leader>hs", gs.stage_hunk,                           "Stage hunk")
          map("n", "<leader>hr", gs.reset_hunk,                           "Reset hunk")
          map("n", "<leader>hS", gs.stage_buffer,                         "Stage buffer")
          map("n", "<leader>hp", gs.preview_hunk,                         "Preview hunk")
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
          map("n", "<leader>hd", gs.diffthis,                             "Diff this")
        end,
      })
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Copy a permalink to the current line/selection on GitHub
  {
    "linrongbin16/gitlinker.nvim",
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Copy git permalink" },
    },
    opts = {},
  },
}
