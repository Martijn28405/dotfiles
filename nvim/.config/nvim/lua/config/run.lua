local Terminal = require("toggleterm.terminal").Terminal

local terms = {}

local function run(name, cmd)
  if not terms[name] then
    terms[name] = Terminal:new({ cmd = cmd, hidden = true, direction = "float", float_opts = { border = "rounded" } })
  end
  terms[name]:toggle()
end

vim.keymap.set("n", "<leader>rr", function() run("run", "make run") end, { silent = true })
vim.keymap.set("n", "<leader>rt", function() run("test", "make test") end, { silent = true })
vim.keymap.set("n", "<leader>rb", function() run("build", "make build") end, { silent = true })

vim.keymap.set("n", "<leader>rT", function() run("pytest", "pytest -q") end, { silent = true })
vim.keymap.set("n", "<leader>rD", function() run("dotnet", "dotnet test") end, { silent = true })
vim.keymap.set("n", "<leader>rN", function() run("npm", "npm test") end, { silent = true })
