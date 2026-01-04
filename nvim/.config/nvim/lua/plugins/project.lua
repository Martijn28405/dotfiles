return {
  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
      detection_methods = { "pattern" },
      patterns = { ".git", "pyproject.toml", "package.json", "Cargo.toml", "go.mod", "Makefile" },
      show_hidden = true,
      silent_chdir = true,
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      pcall(require("telescope").load_extension, "projects")
    end,
  },
}
