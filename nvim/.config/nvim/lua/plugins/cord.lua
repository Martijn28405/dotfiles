if vim.env.SSH_CONNECTION then
  return {}
end

return {
  {
    "vyfor/cord.nvim",
    event = "VeryLazy",
    opts = (function()
      local markers = {
        ".git",
        "package.json",
        "pyproject.toml",
        "Cargo.toml",
        "*.sln",
        "*.csproj",
      }

      local function workspace_name()
        local cwd = vim.fn.getcwd()
        local root = vim.fs.root(0, markers) or cwd
        return vim.fn.fnamemodify(root, ":t")
      end

      local function diag_counts()
        local bufnr = vim.api.nvim_get_current_buf()
        local diags = vim.diagnostic.get(bufnr)
        local e, w = 0, 0
        for _, d in ipairs(diags) do
          if d.severity == vim.diagnostic.severity.ERROR then e = e + 1 end
          if d.severity == vim.diagnostic.severity.WARN then w = w + 1 end
        end
        return e, w
      end

      local function ro_suffix(opts)
        return opts.is_read_only and " (read-only)" or ""
      end

      local function is_telescope()
        local ft = vim.bo.filetype
        return ft == "TelescopePrompt" or ft == "TelescopeResults"
      end

      local function is_lazy()
        return vim.bo.filetype == "lazy"
      end



local function is_lazygit()
  return vim.bo.filetype == "lazygit"
end


    local function terminal_activity()
  return nil
end


      return {
        text = {
          workspace = function()
            return ("Somewhere inside %s"):format(workspace_name())
          end,

          editing = function(opts)
            if is_telescope() then
              if vim.g.cord_telescope_mode == "files" then
                return "Looking for a file. Any file."
              end
              if vim.g.cord_telescope_mode == "grep" then
                return "Searching text. Regretting past naming choices."
              end
              return "Searching. Confidently."
            end

            if is_lazy() then
              return "Installing more plugins. For stability."
            end

            if is_lazygit() then
              return "Using LazyGit. Decisions will be made."
            end

            local e, w = diag_counts()
            local ro = ro_suffix(opts)

            if e > 0 then
              if e == 1 then
                return ("Putting out one fire in %s%s"):format(opts.filename, ro)
              end
              return ("Putting out %d fires in %s%s"):format(e, opts.filename, ro)
            end

            if w > 0 then
              if w == 1 then
                return ("Ignoring one warning in %s%s"):format(opts.filename, ro)
              end
              return ("Ignoring %d warnings in %s%s"):format(w, opts.filename, ro)
            end

            return ("Editing %s%s (no fires today)"):format(opts.filename, ro)
          end,

          viewing = function(opts)
            if is_telescope() then
              if vim.g.cord_telescope_mode == "files" then
                return "Found files. Choosing poorly."
              end
              if vim.g.cord_telescope_mode == "grep" then
                return "Search results. The culprit is nearby."
              end
              return "Results. Surely correct."
            end

            if is_lazy() then return "Reading plugin descriptions." end
            if is_lazygit() then return "Reviewing history. Regretting it." end

            return ("Staring at %s%s"):format(opts.filename, ro_suffix(opts))
          end,

          terminal = function()
            if is_lazygit() then return "Using LazyGit. Decisions will be made." end
            return terminal_activity() or "Typing commands carefully."
          end,

          file_browser = function()
            if vim.g.cord_telescope_mode == "files" then
              return "Looking for a file. Any file."
            end
            if vim.g.cord_telescope_mode == "grep" then
              return "Searching text. Regretting past naming choices."
            end
            return "Searching for something. Not sure what."
          end,

          plugin_manager = "Installing more plugins. For stability.",
          vcs = "Negotiating with git.",
        },

        idle = {
          smart_idle = true,
          details = "Thinking about a better approach.",
        },

        buttons = {
          { label = "Neovim", url = "https://neovim.io" },
        },

        advanced = {
          plugin = { cursor_update = "on_move" },
          workspace = { root_markers = markers },
        },
      }
    end)(),
  },
}
