
local M = {}

local themes = {
  "catppuccin",
  "kanagawa",
  "kanagawa-dragon",
  "dracula",
}

local default_theme = "catppuccin"
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
  local original = M.current()
  local confirmed = false

  local ok, _ = pcall(require, "telescope")
  if not ok then
    vim.ui.select(themes, { prompt = "Theme" }, function(choice)
      if choice then apply(choice, true) else apply(original, false) end
    end)
    return
  end

  local pickers  = require("telescope.pickers")
  local finders  = require("telescope.finders")
  local conf     = require("telescope.config").values
  local actions  = require("telescope.actions")
  local state    = require("telescope.actions.state")

  pickers.new({}, {
    prompt_title = "Theme",
    finder = finders.new_table({ results = themes }),
    sorter = conf.generic_sorter({}),

    attach_mappings = function(prompt_bufnr)
      local function preview_current()
        local entry = state.get_selected_entry()
        if entry then apply(entry.value, false) end
      end

      -- Hook into every selection-movement action so hovering previews the theme
      actions.move_selection_next:enhance({ post = preview_current })
      actions.move_selection_previous:enhance({ post = preview_current })
      actions.move_to_top:enhance({ post = preview_current })
      actions.move_to_bottom:enhance({ post = preview_current })
      actions.move_to_middle:enhance({ post = preview_current })

      -- Also preview when the search query changes (first result may change)
      vim.api.nvim_create_autocmd("TextChangedI", {
        buffer = prompt_bufnr,
        callback = vim.schedule_wrap(preview_current),
      })

      -- Confirm: grab entry BEFORE close (state is gone after)
      actions.select_default:replace(function()
        local entry = state.get_selected_entry()
        confirmed = true
        actions.close(prompt_bufnr)
        if entry then
          apply(entry.value, true)
        else
          apply(original, false)
        end
      end)

      -- Cancel: restore original (guarded so confirm doesn't also restore)
      actions.close:enhance({
        post = function()
          if not confirmed then
            apply(original, false)
          end
        end,
      })

      return true
    end,
  }):find()
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
