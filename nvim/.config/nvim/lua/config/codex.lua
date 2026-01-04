local Terminal = require("toggleterm.terminal").Terminal

local function set_codex_status(s)
  vim.g.codex_status = s
  pcall(require("lualine").refresh)
end

vim.g.codex_status = vim.g.codex_status or "idle"

local codex = Terminal:new({
  cmd = "codex",
  hidden = true,
  direction = "float",
  float_opts = { border = "rounded" },
  start_in_insert = true,

  on_open = function()
    set_codex_status("open")
  end,

  on_close = function()
    set_codex_status("idle")
  end,


on_stdout = function(_, data)
  if data == nil then return end

  local chunk = ""
  if type(data) == "table" then
    chunk = table.concat(data, "\n")
  elseif type(data) == "string" then
    chunk = data
  else
    return
  end

  if chunk:find("›", 1, true) then
    set_codex_status("ready")
    return
  end

  if chunk:find("•", 1, true) then
    set_codex_status("thinking")
  end
end,
})

local function codex_open()
  codex:toggle()
  set_codex_status(codex:is_open() and "open" or "idle")
end

local function codex_send(text)
  if not text or text == "" then return end
  if not codex:is_open() then
    codex_open()
  end
  set_codex_status("thinking")
  vim.defer_fn(function()
    if codex.job_id then
      vim.api.nvim_chan_send(codex.job_id, text)
    end
  end, 120)
end

local function get_visual_selection()
  local _, ls, cs = unpack(vim.fn.getpos("'<"))
  local _, le, ce = unpack(vim.fn.getpos("'>"))

  -- In Visual mode, '< and '> may not be updated yet; use v/. as a fallback.
  if ls == 0 or le == 0 then
    local _, vls, vcs = unpack(vim.fn.getpos("v"))
    local _, vle, vce = unpack(vim.fn.getpos("."))
    ls, cs, le, ce = vls, vcs, vle, vce
  end

  if ls == 0 or le == 0 then return "" end

  if ls > le or (ls == le and cs > ce) then
    ls, le = le, ls
    cs, ce = ce, cs
  end

  local lines = vim.fn.getline(ls, le)
  if #lines == 0 then return "" end

  lines[1] = string.sub(lines[1], cs)
  lines[#lines] = string.sub(lines[#lines], 1, ce)
  return table.concat(lines, "\n")
end

-- Space ac → open/close
vim.keymap.set("n", "<leader>ac", function()
  codex_open()
end, { silent = true })

vim.keymap.set("t", "<leader>ac", function()
  codex_open()
end, { silent = true })

-- Visual + Space ac → selection to codex
vim.keymap.set("v", "<leader>ac", function()
  local sel = get_visual_selection()
  vim.cmd("normal! gv")
  codex_send("\n\n---\nContext:\n```text\n" .. sel .. "\n```\n\n")
end, { silent = true })

-- Space af → current file path
vim.keymap.set("n", "<leader>af", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then return end
  codex_send("\n\n---\nFile:\n" .. file .. "\n\n")
end, { silent = true })

-- Space aC → current file inline
vim.keymap.set("n", "<leader>aC", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then return end
  local lines = vim.fn.readfile(file)
  local text = table.concat(lines, "\n")
  codex_send("\n\n---\nFile contents:\n```text\n" .. text .. "\n```\n\n")
end, { silent = true })

-- Space aF → multi-file via Telescope (TAB select, ENTER send)
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

local function selection_context()
  local sel = get_visual_selection()
  if sel == "" then
    return nil
  end

  local file = vim.api.nvim_buf_get_name(0)
  local ft = vim.bo.filetype
  local ls = vim.fn.line("'<")
  local le = vim.fn.line("'>")

  return {
    sel = sel,
    file = (file ~= "" and file or "[No Name]"),
    ft = (ft ~= "" and ft or "text"),
    range = ("%d-%d"):format(ls, le),
  }
end

local function codex_send_selection_with_prompt(prompt)
  local ctx = selection_context()
  if not ctx then
    return
  end

  -- Keep selection highlighted (optional)
  vim.cmd("normal! gv")

  local msg =
    "\n\n---\n" ..
    "File: " .. ctx.file .. "\n" ..
    "Type: " .. ctx.ft .. "\n" ..
    "Lines: " .. ctx.range .. "\n\n" ..
    "Selected code:\n```" .. ctx.ft .. "\n" .. ctx.sel .. "\n```\n\n" ..
    "Task:\n" .. prompt .. "\n\n"

  codex_send(msg)
end


local M = {}
M.open = codex_open
M.send = codex_send
M.send_selection_with_prompt = codex_send_selection_with_prompt
return M
