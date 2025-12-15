return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'catppuccin' },
    opts = function()
      return {
        options = {
          show_close_icon = false,
          show_buffer_close_icons = false,
          separator_style = 'thick',
        },
        highlights = require('catppuccin.special.bufferline').get_theme(),
      }
    end,
  },
}
