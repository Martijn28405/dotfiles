vim.g.autoformat_enabled = false

vim.api.nvim_create_user_command("FormatToggle", function()
  vim.g.autoformat_enabled = not vim.g.autoformat_enabled
  local state = vim.g.autoformat_enabled and "ON" or "OFF"
  vim.notify("Format on save: " .. state, vim.log.levels.INFO)
end, { desc = "Toggle format on save" })

vim.keymap.set("n", "<leader>uf", "<cmd>FormatToggle<cr>", {
  noremap = true,
  silent = true,
  desc = "Toggle format on save",
})
