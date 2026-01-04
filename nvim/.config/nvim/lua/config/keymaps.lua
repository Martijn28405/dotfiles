local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>pv", "<cmd>NvimTreeToggle<cr>", opts)

keymap({ "n", "v" }, "<leader>fm", function()
  require("conform").format({ timeout_ms = 2000, lsp_fallback = true })
end, opts)

local tb = require("telescope.builtin")

keymap("n", "<leader>ff", function()
  vim.g.cord_telescope_mode = "files"
  tb.find_files()
end, opts)

keymap("n", "<leader>fg", function()
  vim.g.cord_telescope_mode = "grep"
  tb.live_grep()
end, opts)

keymap("n", "<leader>fb", tb.buffers, opts)
keymap("n", "<leader>fh", tb.help_tags, opts)
keymap("n", "<leader>fd", tb.diagnostics, opts)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.api.nvim_create_autocmd("BufWipeout", {
      buffer = 0,
      once = true,
      callback = function()
        vim.g.cord_telescope_mode = nil
      end,
    })
  end,
})

