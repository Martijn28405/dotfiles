
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

local default_theme = "tokyonight-storm"
local theme_file = vim.fn.stdpath("state") .. "/theme.txt"

local function ensure_state_dir()
  vim.fn.mkdir(vim.fn.fnamemodify(theme_file, ":h"), "p")
end

local function apply(name, persist)
  name = name or default_theme

  local ok = pcall(vim.cmd.colorscheme, name)
  if not ok then
    -- fallback, nooit zwart scherm
    pcall(vim.cmd.colorscheme, default_theme)
    vim.g.active_colorscheme = default_theme
    return
  end

  vim.g.active_colorscheme = name

  if persist then
    ensure_state_dir()
    pcall(vim.fn.writefile, { name }, theme_file)
  end
end

function M.pick()
  vim.ui.select(themes, { prompt = "Theme" }, function(choice)
    if choice then
      apply(choice, true)
    end
  end)
end

function M.load()
  if vim.fn.filereadable(theme_file) ~= 1 then
    apply(default_theme, false)
    return
  end

  local lines = vim.fn.readfile(theme_file)
  local name = (lines and lines[1] and lines[1] ~= "") and lines[1] or default_theme
  apply(name, false)
end

function M.current()
  return vim.g.active_colorscheme or default_theme
end

M.apply = function(name)
  apply(name, true)
end

return M
