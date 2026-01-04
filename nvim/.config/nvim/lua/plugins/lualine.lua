return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.api.nvim_set_hl(0, "CodexIdle",     { fg = "#6c7086" })
      vim.api.nvim_set_hl(0, "CodexOpen",     { fg = "#89b4fa" })
      vim.api.nvim_set_hl(0, "CodexThinking", { fg = "#cba6f7", bold = true })
      vim.api.nvim_set_hl(0, "CodexReady",    { fg = "#a6e3a1", bold = true })

      local function codex_component()
        local s = vim.g.codex_status or "idle"

        if s == "thinking" then
          return "%#CodexThinking#󰭻 thinking%*"
        elseif s == "ready" then
          return "%#CodexReady#󰭻 ready%*"
        elseif s == "open" then
          return "%#CodexOpen#󰭻 open%*"
        end

        return "%#CodexIdle#󰭻%*"
      end

      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          section_separators = "",
          component_separators = "",
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
