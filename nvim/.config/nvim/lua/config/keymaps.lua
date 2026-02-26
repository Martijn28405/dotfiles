local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap({ "n", "v" }, "<leader>fm", function()
  require("conform").format({ timeout_ms = 2000, lsp_fallback = true })
end, opts)

local tb = require("telescope.builtin")

local function file_dir()
  local file_dir = vim.fn.expand("%:p:h")
  return file_dir ~= "" and file_dir or nil
end

local function with_mode(mode, fn)
  return function()
    vim.g.cord_telescope_mode = mode
    fn()
  end
end

local function has_lsp_client(bufnr)
  return #vim.lsp.get_clients({ bufnr = bufnr or 0 }) > 0
end

local function lsp_rename()
  if not has_lsp_client(0) then
    vim.notify("Geen LSP actief in deze buffer", vim.log.levels.WARN)
    return
  end
  vim.lsp.buf.rename()
end

local function lsp_code_action()
  if not has_lsp_client(0) then
    vim.notify("Geen LSP actief in deze buffer", vim.log.levels.WARN)
    return
  end
  vim.lsp.buf.code_action()
end

keymap("n", "<leader>ff", with_mode("files", function()
  tb.find_files({ cwd = file_dir() })
end), opts)

keymap("n", "<leader>fF", with_mode("files", function()
  tb.find_files()
end), opts)

keymap("n", "<leader>fg", with_mode("grep", function()
  tb.live_grep({ cwd = file_dir() })
end), opts)

keymap("n", "<leader>fG", with_mode("grep", function()
  tb.live_grep()
end), opts)

keymap("n", "<leader>fb", tb.buffers, opts)
keymap("n", "<leader>fh", tb.help_tags, opts)
keymap("n", "<leader>fd", tb.diagnostics, opts)
keymap("n", "<leader>cr", lsp_rename, opts)
keymap({ "n", "v" }, "<leader>ca", lsp_code_action, opts)

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
