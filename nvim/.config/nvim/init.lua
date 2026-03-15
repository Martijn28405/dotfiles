require("config")

if vim.g.neovide then
  -- Cursor animatie (zoals je leuk vindt)
  vim.g.neovide_cursor_animation_length     = 0.08
  vim.g.neovide_cursor_trail_size           = 0.35
  vim.g.neovide_cursor_vfx_mode             = "railgun"
  vim.g.neovide_cursor_vfx_particle_lifetime = 0.5
  vim.g.neovide_cursor_vfx_particle_density  = 10.0
  vim.g.neovide_cursor_vfx_particle_speed    = 15.0
  vim.g.neovide_cursor_vfx_particle_phase    = 2.0
  vim.g.neovide_cursor_vfx_particle_curl     = 1.0
  vim.g.neovide_cursor_animate_in_insert_mode   = true
  vim.g.neovide_cursor_animate_command_line     = true

  -- Scroll & position
  vim.g.neovide_scroll_animation_length     = 0.15
  vim.g.neovide_scroll_animation_far_lines  = 1
  vim.g.neovide_position_animation_length   = 0.12

  -- Transparency
  vim.g.neovide_opacity          = 0.93
  vim.g.neovide_normal_opacity   = 1.0

  vim.g.neovide_window_blurred = true          -- hele window blur (macOS)
  vim.g.neovide_floating_corner_radius = 0.15  -- ronde hoeken op popups
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 8
  -- Nieuwe leuke toevoegingen
  vim.o.guifont = "JetBrainsMono Nerd Font:h13"  -- pas font/size aan
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_floating_blur_amount_x = 4.0     -- blur op floats
  vim.g.neovide_floating_blur_amount_y = 4.0
  vim.g.neovide_refresh_rate = 120               -- of 60/144 afhankelijk van scherm
  vim.g.neovide_no_idle = true
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_emoji_font = "Apple Color Emoji"

  -- Snelle keymaps voor tunen
  vim.keymap.set({ 'n', 'v' }, '<D-M-Up>', function()
    vim.g.neovide_opacity = math.min(1.0, (vim.g.neovide_opacity or 1.0) + 0.02)
  end, { desc = "Opacity +", silent = true })

  vim.keymap.set({ 'n', 'v' }, '<D-M-Down>', function()
    vim.g.neovide_opacity = math.max(0.7, (vim.g.neovide_opacity or 1.0) - 0.02)
  end, { desc = "Opacity -", silent = true })

  vim.keymap.set({ 'n', 'v' }, '<D-=>', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.05
  end, { desc = "Zoom +", silent = true })

  vim.keymap.set({ 'n', 'v' }, '<D-->', function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.05
  end, { desc = "Zoom -", silent = true })
end
