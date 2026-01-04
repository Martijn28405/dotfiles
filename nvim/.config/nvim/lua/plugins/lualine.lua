return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
     local function codex_component()
          local icon = "󰭻" -- Chat / AI icon (Nerd Font)
          local status = vim.g.codex_status or "idle"

      local labels = {
        idle = "idle",
        open = "open",
        thinking = "thinking",
        ready = "ready",
      }

      return icon .. " " .. (labels[status] or status)
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
          lualine_x = {
            codex_component,
            "filetype",
          },
          lualine_y = {},
          lualine_z = { "location" },
        },
      })

      vim.api.nvim_create_autocmd({ "TermOpen", "TermClose", "BufEnter", "WinEnter" }, {
        callback = function()
          pcall(require("lualine").refresh)
        end,
      })
    end,
  },
}
