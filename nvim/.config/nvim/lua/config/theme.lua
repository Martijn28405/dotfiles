local M = {}

local themes = {
  "tokyonight-storm",
  "tokyonight-night",
  "catppuccin",
  "kanagawa",
  "kanagawa-dragon",
  "nightfox",
  "duskfox",
  "nordfox",
}

local theme_file = vim.fn.stdpath("state") .. "/theme.txt"

local function apply(name)
  local ok = pcall(vim.cmd.colorscheme, name)
  if ok then
    vim.fn.writefile({ name }, theme_file)
  end
end

function M.pick()
  vim.ui.select(themes, { prompt = "Theme" }, function(choice)
    if choice then
      apply(choice)
    end
  end)
end

function M.load()
  if vim.fn.filereadable(theme_file) ~= 1 then
    return
  end

  local lines = vim.fn.readfile(theme_file)
  if lines and lines[1] and lines[1] ~= "" then
    pcall(vim.cmd.colorscheme, lines[1])
  end
end

M.apply = apply

return M
