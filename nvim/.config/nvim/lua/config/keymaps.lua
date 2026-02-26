local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

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

vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { noremap = true, silent = true })

vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>ut", function()
  require("config.theme").pick()
end, { silent = true })

-- Markdown preview
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "mmd", "mermaid" },
  callback = function(event)
    local map_opts = { noremap = true, silent = true, buffer = event.buf }
    keymap("n", "<leader>mps", "<cmd>MarkdownPreview<cr>", map_opts)
    keymap("n", "<leader>mpr", "<cmd>MarkdownPreviewRefresh<cr>", map_opts)
    keymap("n", "<leader>mpS", "<cmd>MarkdownPreviewStop<cr>", map_opts)
  end,
})
