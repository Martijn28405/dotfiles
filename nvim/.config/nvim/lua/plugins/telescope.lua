return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        file_finder_cmd = { "fd", "--type", "f", "--hidden", "--no-ignore-vcs" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--no-ignore-vcs",
        },
        file_ignore_patterns = {},
        layout_strategy = "vertical",
        layout_config = {
          prompt_position = "bottom",
          height = 0.9,
        },
      },
      pickers = {
        find_files = {
          find_command = { "fd", "--type", "f", "--hidden", "--no-ignore-vcs" },
        },
      },
    },
  },
}

