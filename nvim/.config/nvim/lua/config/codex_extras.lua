local function send_template(title, body)
  local codex_send = require("config.codex").send
  codex_send("\n\n" .. title .. "\n" .. body .. "\n\n")
end

local codex = require("config.codex")

local function prompt_for_continue()
  vim.ui.input({ prompt = "Codex continue: " }, function(input)
    if not input or input == "" then return end
    send_template("Continue", "continue " .. input)
  end)
end



vim.keymap.set("n", "<leader>aR", prompt_for_continue, { silent = true })


vim.keymap.set("v", "<leader>ax", function()
  codex.send_selection_with_prompt(
    "Explain what this code does, then propose a concrete fix or improvement. Be specific and reference the lines."
  )
end, { silent = true, desc = "Explain + fix (visual)" })

vim.keymap.set("v", "<leader>ar", function()
  codex.send_selection_with_prompt(
    "Refactor this to be simpler and more readable, keeping behavior identical. Return the updated code."
  )
end, { silent = true, desc = "Refactor (visual)" })

vim.keymap.set("v", "<leader>at", function()
  codex.send_selection_with_prompt(
    "Write tests for this. Include edge cases. Tell me where to place the tests and how to run them."
  )
end, { silent = true, desc = "Write tests (visual)" })

vim.keymap.set("v", "<leader>ab", function()
  codex.send_selection_with_prompt(
    "Find the bug or potential bug(s) in this code. Explain how to reproduce and how to fix."
  )
end, { silent = true, desc = "Find bug (visual)" })

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
