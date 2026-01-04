
vim.api.nvim_set_hl(0, "CodexIdle",     { fg = "#6c7086" })
vim.api.nvim_set_hl(0, "CodexOpen",     { fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "CodexThinking", { fg = "#cba6f7", bold = true })
vim.api.nvim_set_hl(0, "CodexReady",    { fg = "#a6e3a1", bold = true })

local function codex_component()
  local s = vim.g.codex_status or "idle"

  if s == "thinking" then
    return "%#CodexThinking# Codex%*"
  elseif s == "ready" then
    return "%#CodexReady# Codex%*"
  elseif s == "open" then
    return "%#CodexOpen# Codex%*"
  end

  return "%#CodexIdle#󰘳 Codex%*"
end

require("lualine").setup({
  sections = {
    lualine_x = {
      codex_component,
      "filetype",
    },
  },
})
