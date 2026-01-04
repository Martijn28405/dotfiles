local Terminal = require("toggleterm.terminal").Terminal

local inline = Terminal:new({
  hidden = true,
  direction = "horizontal",
  size = 15,
})

local function term_toggle()
  inline:toggle()
end

local function term_send(cmd)
  if not cmd or cmd == "" then return end
  if not inline:is_open() then inline:open() end
  if inline.job_id then
    vim.api.nvim_chan_send(inline.job_id, cmd .. "\n")
  end
end

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

vim.keymap.set("n", "<leader>tt", term_toggle, { silent = true, desc = "Terminal toggle" })
vim.keymap.set("t", "<leader>tt", term_toggle, { silent = true })

vim.keymap.set("n", "<leader>tc", function()
  term_send("clear")
end, { silent = true, desc = "Terminal clear" })

vim.keymap.set("n", "<leader>tr", function()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then return end

  local ft = vim.bo.filetype
  local cmd = nil

  if ft == "python" then
    cmd = "python " .. vim.fn.shellescape(file)
  elseif ft == "javascript" then
    cmd = "node " .. vim.fn.shellescape(file)
  elseif ft == "typescript" then
    cmd = "node " .. vim.fn.shellescape(file)
  elseif ft == "sh" or ft == "bash" then
    cmd = "bash " .. vim.fn.shellescape(file)
  elseif ft == "lua" then
    cmd = "lua " .. vim.fn.shellescape(file)
  else
    vim.ui.input({ prompt = "Run command: " }, function(input)
      if input and input ~= "" then
        term_send(input)
      end
    end)
    return
  end

  term_send(cmd)
end, { silent = true, desc = "Run current file" })

return {
  toggle = term_toggle,
  send = term_send,
}
