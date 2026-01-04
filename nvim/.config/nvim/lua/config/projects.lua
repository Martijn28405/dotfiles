vim.keymap.set("n", "<leader>pp", function()
  require("telescope").extensions.projects.projects({})
end, { silent = true })
