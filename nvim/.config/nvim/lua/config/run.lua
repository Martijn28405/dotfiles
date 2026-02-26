local ok, term = pcall(require, "toggleterm.terminal")
if not ok then
  return
end

local Terminal = term.Terminal

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

vim.keymap.set("n", "<leader>rD", function() run("dotnet", "dotnet test") end, { silent = true })
