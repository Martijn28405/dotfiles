local ok_term, toggleterm = pcall(require, "toggleterm.terminal")
if not ok_term then
  return
end

local Terminal = toggleterm.Terminal
local CONTINUE_CMD = "continue"


-- ---------- helpers ----------

local function get_visual_selection()
  local _, ls, cs = unpack(vim.fn.getpos("'<"))
  local _, le, ce = unpack(vim.fn.getpos("'>"))
  if ls == 0 or le == 0 then return "" end

  local lines = vim.fn.getline(ls, le)
  if #lines == 0 then return "" end

  lines[1] = string.sub(lines[1], cs)
  lines[#lines] = string.sub(lines[#lines], 1, ce)
  return table.concat(lines, "\n")
end

-- ---------- codex terminal ----------

local codex = Terminal:new({
  cmd = "codex",
  hidden = true,
  direction = "float",
  float_opts = { border = "rounded" },
  start_in_insert = true,
})

local function codex_open()
  codex:toggle()
end

local function codex_send(text)
  if not text or text == "" then return end
  if not codex:is_open() then
    codex_open()
  end
  vim.defer_fn(function()
    if codex.job_id then
      vim.api.nvim_chan_send(codex.job_id, text)
    end
  end, 120)
end

local function codex_continue(arg)
  codex_open()
  if arg and arg ~= "" then
    codex_send(CONTINUE_CMD .. " " .. arg .. "\n")
  else
    codex_send(CONTINUE_CMD .. "\n")
  end
end

-- ---------- keymaps ----------

-- Space ac → Codex openen / sluiten
vim.keymap.set("n", "<leader>ac", codex_open, { silent = true })
vim.keymap.set("t", "<leader>ac", codex_open, { silent = true })

-- Visual + Space ac → selectie naar Codex
vim.keymap.set("v", "<leader>ac", function()
  local sel = get_visual_selection()
  vim.cmd("normal! gv")
  codex_send("\n\n---\nContext:\n```text\n" .. sel .. "\n```\n\n")
end, { silent = true })

-- Space af → huidige file (pad)
vim.keymap.set("n", "<leader>af", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then return end
  codex_send("\n\n---\nFile:\n" .. file .. "\n\n")
end, { silent = true })

-- Space aC → huidige file inline
vim.keymap.set("n", "<leader>aC", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then return end

  local lines = vim.fn.readfile(file)
  local text = table.concat(lines, "\n")

  codex_send("\n\n---\nFile contents:\n```text\n" .. text .. "\n```\n\n")
end, { silent = true })

-- Space aF → meerdere files via Telescope
vim.keymap.set("n", "<leader>aF", function()
  require("telescope.builtin").find_files({
    attach_mappings = function(_, map)
      local actions = require("telescope.actions")
      local state = require("telescope.actions.state")

      map("i", "<CR>", function(prompt_bufnr)
        local picker = state.get_current_picker(prompt_bufnr)
        local selections = picker:get_multi_selection()
        actions.close(prompt_bufnr)

        if #selections == 0 then return end

        codex_open()
        codex_send("\n\n---\nFiles:\n")
        for _, entry in ipairs(selections) do
          codex_send(entry.path .. "\n")
        end
        codex_send("\n")
      end)

      return true
    end,
  })
end, { silent = true })

-- Space ar -> Continue command
vim.keymap.set("n", "<leader>ar", function()
  codex_continue()
end, { silent = true })
