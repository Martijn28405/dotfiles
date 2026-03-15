local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Format
keymap({ "n", "v" }, "<leader>fm", function()
  require("conform").format({ timeout_ms = 2000, lsp_fallback = true })
end, opts)

-- Telescope
local function tb()
  return require("telescope.builtin")
end

local function file_dir()
  local dir = vim.fn.expand("%:p:h")
  return dir ~= "" and dir or nil
end

local function with_mode(mode, fn)
  return function()
    vim.g.cord_telescope_mode = mode
    fn()
  end
end

keymap("n", "<leader>ff", with_mode("files", function() tb().find_files({ cwd = file_dir() }) end), opts)
keymap("n", "<leader>fF", with_mode("files", function() tb().find_files() end), opts)
keymap("n", "<leader>fg", with_mode("grep", function() tb().live_grep({ cwd = file_dir() }) end), opts)
keymap("n", "<leader>fG", with_mode("grep", function() tb().live_grep() end), opts)
keymap("n", "<leader>fb", function() tb().buffers() end, opts)
keymap("n", "<leader>fh", function() tb().help_tags() end, opts)
keymap("n", "<leader>fd", function() tb().diagnostics() end, opts)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    vim.api.nvim_create_autocmd("BufWipeout", {
      buffer = 0, once = true,
      callback = function() vim.g.cord_telescope_mode = nil end,
    })
  end,
})

-- LSP actions
local function has_lsp_client(bufnr)
  return #vim.lsp.get_clients({ bufnr = bufnr or 0 }) > 0
end

keymap("n", "<leader>cr", function()
  if has_lsp_client(0) then vim.lsp.buf.rename() end
end, opts)

keymap({ "n", "v" }, "<leader>ca", function()
  if has_lsp_client(0) then vim.lsp.buf.code_action() end
end, opts)

-- Flash jump / treesitter
keymap({ "n", "x", "o" }, "s", function() require("flash").jump() end, opts)
keymap({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, opts)

-- Theme picker
keymap("n", "<leader>ut", function() require("config.theme").pick() end, { silent = true })

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

-- Neo-tree
keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", vim.tbl_extend("force", opts, { desc = "Toggle File Explorer" }))

-- Bufferline
keymap("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", vim.tbl_extend("force", opts, { desc = "Go to Buffer 1" }))
keymap("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", vim.tbl_extend("force", opts, { desc = "Go to Buffer 2" }))
keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", vim.tbl_extend("force", opts, { desc = "Next Buffer" }))
keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", vim.tbl_extend("force", opts, { desc = "Previous Buffer" }))

-- Splits (open file in vertical split via Telescope)
local has_telescope, tscope = pcall(require, "telescope.builtin")
if has_telescope then
  keymap("n", "<leader>vs", function()
    tscope.find_files({
      prompt_title = "Open in vertical split",
      attach_mappings = function(prompt_bufnr, map)
        local actions = require("telescope.actions")
        local actions_state = require("telescope.actions.state")
        map({ "i", "n" }, "<CR>", function()
          local sel = actions_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if sel then vim.cmd("vsplit " .. vim.fn.fnameescape(sel.path)) end
        end)
        return true
      end,
    })
  end, { desc = "Vertical split: pick file" })
else
  keymap("n", "<leader>vs", ":vsplit ", { desc = "Vertical split" })
end
