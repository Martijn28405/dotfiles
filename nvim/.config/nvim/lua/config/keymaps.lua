local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Formatteren
keymap({ "n", "v" }, "<leader>fm", function()
  require("conform").format({ timeout_ms = 2000, lsp_fallback = true })
end, opts)

keymap("n", "<leader>tf", function()
  vim.g.autoformat_enabled = vim.g.autoformat_enabled ~= false and false or nil
  local state = vim.g.autoformat_enabled == false and "disabled" or "enabled"
  vim.notify("Auto-format on save: " .. state)
end, { desc = "Toggle auto-format on save" })

-- Telescope lazy-load helpers
local function tb()
  return require("telescope.builtin")
end

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

-- LSP helpers
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

-- Telescope keymaps
keymap("n", "<leader>ff", with_mode("files", function()
  tb().find_files({ cwd = file_dir() })
end), opts)

keymap("n", "<leader>fF", with_mode("files", function()
  tb().find_files()
end), opts)

keymap("n", "<leader>fg", with_mode("grep", function()
  tb().live_grep({ cwd = file_dir() })
end), opts)

keymap("n", "<leader>fG", with_mode("grep", function()
  tb().live_grep()
end), opts)

keymap("n", "<leader>fb", function() tb().buffers() end, opts)
keymap("n", "<leader>fh", function() tb().help_tags() end, opts)
keymap("n", "<leader>fd", function() tb().diagnostics() end, opts)

-- LSP actions
keymap("n", "<leader>cr", lsp_rename, opts)
keymap({ "n", "v" }, "<leader>ca", lsp_code_action, opts)

-- Telescope prompt cleanup
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

-- Flash jump / treesitter
vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { noremap = true, silent = true })

vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { noremap = true, silent = true })

-- Theme picker
vim.keymap.set("n", "<leader>ut", function()
  require("config.theme").pick()
end, { silent = true })

-- Markdown preview (nu correct afgesloten)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "mmd", "mermaid" },
  callback = function(event)
    local map_opts = { noremap = true, silent = true, buffer = event.buf }
    keymap("n", "<leader>mps", "<cmd>MarkdownPreview<cr>", map_opts)
    keymap("n", "<leader>mpr", "<cmd>MarkdownPreviewRefresh<cr>", map_opts)
    keymap("n", "<leader>mpS", "<cmd>MarkdownPreviewStop<cr>", map_opts)
  end,  -- ← dit was ontbrekend → nu correct gesloten
})

-- IDE-achtige sidebar toggles
keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", vim.tbl_extend("force", opts, { desc = "Toggle File Explorer (Neo-tree)" }))
keymap("n", "<leader>o", "<cmd>Outline<cr>", vim.tbl_extend("force", opts, { desc = "Toggle Outline / Symbols Sidebar" }))

-- Bufferline: direct naar buffer 1/2
keymap("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", vim.tbl_extend("force", opts, { desc = "Go to Buffer 1" }))
keymap("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", vim.tbl_extend("force", opts, { desc = "Go to Buffer 2" }))

-- Bufferline cycle met Tab / Shift-Tab
keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", vim.tbl_extend("force", opts, { desc = "Next Buffer" }))
keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", vim.tbl_extend("force", opts, { desc = "Previous Buffer" }))
