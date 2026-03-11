-- lua/config/splits.lua
-- Makkelijk een ander bestand openen in verticale split
-- Werkt mét én zonder Telescope (automatische fallback)


-- === MET TELESCOPE (aanbevolen, super snel) ===
local has_telescope, telescope = pcall(require, "telescope.builtin")

if has_telescope then
  -- <leader>vs → kies bestand met Telescope en open direct rechts
  vim.keymap.set("n", "<leader>vs", function()
    telescope.find_files({
      prompt_title = "Open in vertical split",
      attach_mappings = function(prompt_bufnr, map)
        local actions = require("telescope.actions")
        local actions_state = require("telescope.actions.state")

        map({ "i", "n" }, "<CR>", function()
          local selection = actions_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            vim.cmd("vsplit " .. vim.fn.fnameescape(selection.path))
          end
        end)
        return true
      end,
    })
  end, { desc = "Vertical split: kies bestand (Telescope)" })

  -- Bonus: <leader>vr → recent files in verticale split
  vim.keymap.set("n", "<leader>vr", function()
    telescope.oldfiles({
      prompt_title = "Open recent in vertical split",
      attach_mappings = function(prompt_bufnr, map)
        local actions = require("telescope.actions")
        local actions_state = require("telescope.actions.state")

        map({ "i", "n" }, "<CR>", function()
          local selection = actions_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            vim.cmd("vsplit " .. vim.fn.fnameescape(selection.path))
          end
        end)
        return true
      end,
    })
  end, { desc = "Vertical split: recent bestand" })
else
  -- === ZONDER TELESCOPE (fallback) ===
  -- <leader>vs → zet je meteen in command mode met :vsplit (Tab = autocomplete!)
  vim.keymap.set("n", "<leader>vs", ":vsplit ", { desc = "Vertical split: typ bestand + Tab" })
end

