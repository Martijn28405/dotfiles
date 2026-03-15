local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- File explorer (netrw)
keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Format with conform
keymap({ "n", "v" }, "<leader>fm", function()
  require("conform").format({ timeout_ms = 2000, lsp_fallback = true })
end, opts)

-- Telescope
local function tb()
  return require("telescope.builtin")
end

keymap("n", "<leader>ff", function() tb().find_files() end, opts)
keymap("n", "<leader>fg", function() tb().live_grep() end, opts)
keymap("n", "<leader>fb", function() tb().buffers() end, opts)
keymap("n", "<leader>fh", function() tb().help_tags() end, opts)
keymap("n", "<leader>fd", function() tb().diagnostics() end, opts)

-- Theme picker
keymap("n", "<leader>ut", function()
  require("config.theme").pick()
end, { silent = true })

-- Move selected lines up/down in visual mode
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor in place when joining lines
keymap("n", "J", "mzJ`z", opts)

-- Keep cursor centered when scrolling
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Keep cursor centered when searching
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Paste over selection without losing clipboard
keymap("x", "<leader>p", [["_dP]], { desc = "Paste (preserve clipboard)" })

-- Yank to system clipboard
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Delete to black hole register
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to void register" })

-- Ctrl-C as Escape in insert mode
keymap("i", "<C-c>", "<Esc>", opts)

-- Disable Q (accidental Ex mode)
keymap("n", "Q", "<nop>", opts)

-- Search and replace current word
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Make file executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Quickfix list navigation
keymap("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
keymap("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix item" })
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev location list item" })
