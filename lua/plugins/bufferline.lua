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
          separator_style = 'slant',
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'File Tree',
              separator = true,
              highlight = 'lualine_a_normal',
            },
          },
        },
        highlights = require('catppuccin.groups.integrations.bufferline').get(),
      }
    end,
  },
}
