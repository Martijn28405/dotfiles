return {
  {
    "nvim-telescope/telescope.nvim",
    -- Only load when a Telescope command or one of the mapped keys is invoked
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = function()
      local themes = require("telescope.themes")
      return {
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
          -- Respect .gitignore; skip common heavy directories
          file_ignore_patterns = { "node_modules/", "dist/", "%.git/" },
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
