return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = function()
      local themes = require("telescope.themes")
      return {
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
        extensions = {
          ["ui-select"] = themes.get_dropdown({}),
        },
      }
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },
}
