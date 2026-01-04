return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.api.nvim_set_hl(0, "CodexIdle",     { fg = "#6c7086" })
      vim.api.nvim_set_hl(0, "CodexOpen",     { fg = "#89b4fa" })
      vim.api.nvim_set_hl(0, "CodexThinking", { fg = "#cba6f7", bold = true })
      vim.api.nvim_set_hl(0, "CodexReady",    { fg = "#a6e3a1", bold = true })

      local spinner = { "|", "/", "-", "\\" }
      vim.g.codex_spinner_frame = spinner[1]

      local spin_i = 1
      local spin_timer = nil

      local function ensure_spinner()
        if spin_timer then return end

        spin_timer = vim.loop.new_timer()
        spin_timer:start(0, 120, vim.schedule_wrap(function()
          if (vim.g.codex_status or "idle") ~= "thinking" then
            vim.g.codex_spinner_frame = spinner[1]
            spin_timer:stop()
            spin_timer:close()
            spin_timer = nil
            return
          end

          spin_i = (spin_i % #spinner) + 1
          vim.g.codex_spinner_frame = spinner[spin_i]
        end))
      end

      local function codex_component()
        local s = vim.g.codex_status or "idle"

        if s == "thinking" then
          ensure_spinner()
          return ("%#CodexThinking#%s Codex%*"):format(vim.g.codex_spinner_frame or spinner[1])
        elseif s == "ready" then
          return "%#CodexReady# Codex%*"
        elseif s == "open" then
          return "%#CodexOpen# Codex%*"
        end

        return "%#CodexIdle#󰘳 Codex%*"
      end

      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          section_separators = "",
          component_separators = "",
          refresh = { statusline = 200, tabline = 0, winbar = 0 },
        },
        sections = {
          lualine_a = { { "mode", fmt = function(s) return s:sub(1, 1) end } },
          lualine_b = { "branch", "diff" },
          lualine_c = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              sections = { "error", "warn" },
              colored = true,
              always_visible = false,
            },
            { "filename", path = 1 },
          },
          lualine_x = { codex_component, "filetype" },
          lualine_y = {},
          lualine_z = { "location" },
        },
      })
    end,
  },
}
