local function send_template(title, body)
  local codex_send = require("config.codex").send
  codex_send("\n\n" .. title .. "\n" .. body .. "\n\n")
end

local function prompt_for_continue()
  vim.ui.input({ prompt = "Codex continue: " }, function(input)
    if not input or input == "" then return end
    send_template("Continue", "continue " .. input)
  end)
end

vim.keymap.set("n", "<leader>ar", function()
  send_template("Continue", "continue")
end, { silent = true })

vim.keymap.set("n", "<leader>aR", prompt_for_continue, { silent = true })

vim.keymap.set("v", "<leader>ax", function()
  send_template("Task", "Explain the selected code and propose a fix. Be concrete and point to exact lines.")
end, { silent = true })

vim.keymap.set("v", "<leader>at", function()
  send_template("Task", "Write tests for the selected code. Include edge cases.")
end, { silent = true })

vim.keymap.set("v", "<leader>ar", function()
  send_template("Task", "Refactor the selected code to be simpler and more readable. Keep behavior the same.")
end, { silent = true })

vim.keymap.set("v", "<leader>ab", function()
  send_template("Task", "Find the bug in the selected code and explain how to reproduce it.")
end, { silent = true })

local ok, wk = pcall(require, "which-key")
if ok then
  wk.add({
    { "<leader>a", group = "ai" },
    { "<leader>ac", desc = "Codex toggle" },
    { "<leader>af", desc = "Send file path" },
    { "<leader>aF", desc = "Send files (Telescope)" },
    { "<leader>aC", desc = "Send file contents" },
    { "<leader>ar", desc = "Codex continue" },
    { "<leader>aR", desc = "Codex continue (prompt)" },
    { "<leader>ax", desc = "Explain + fix (visual)" },
    { "<leader>at", desc = "Write tests (visual)" },
    { "<leader>ab", desc = "Find bug (visual)" },
  })
end
