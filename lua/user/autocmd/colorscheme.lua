local set_hl = vim.api.nvim_set_hl
local customize_colors = function()
  local colors = require('user.data.theme_colors')()
  set_hl(0, 'TSField', {
    fg = colors.green_alt2,
  })
  set_hl(0, 'TSVariable', {
    fg = colors.green_alt,
  })
  set_hl(0, 'LightBulbSign', {
    fg = colors.yellow,
  })
end

local group = vim.api.nvim_create_augroup('user_colorscheme', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = group,
  callback = customize_colors,
})
