if not vim.g.neovide then
  return
end

vim.o.guifont = 'MesloLGS Nerd Font:h18'

-- Window settings
vim.g.neovide_fullscreen = true
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0

-- Disable animations
vim.g.neovide_position_animation_length = 0.0
vim.g.neovide_scroll_animation_length = 0.0
vim.g.neovide_cursor_animation_length = 0.0

-- Disable FX for floating windows
vim.g.neovide_floating_shadow = false
vim.g.neovide_floating_corner_radius = 0.0
vim.g.neovide_floating_blur_amount_x = 0.0
vim.g.neovide_floating_blur_amount_y = 0.0
