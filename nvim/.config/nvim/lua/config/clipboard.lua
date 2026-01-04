if not vim.env.SSH_CONNECTION then
  return
end

local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
if not ok then
  return
end

vim.g.clipboard = {
  name = "osc52",
  copy = {
    ["+"] = osc52.copy("+"),
    ["*"] = osc52.copy("*"),
  },
  paste = {
    ["+"] = osc52.paste("+"),
    ["*"] = osc52.paste("*"),
  },
}

vim.opt.clipboard = "unnamedplus"
