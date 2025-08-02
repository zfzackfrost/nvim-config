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
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'File Tree  ',
              separator = true,
              highlight = 'BufferlineBanner',
            },
            {
              filetype = 'grug-far',
              text = 'Grug Far  ',
              separator = true,
              highlight = 'BufferlineBanner',
            },
          },
        },
        highlights = require('catppuccin.groups.integrations.bufferline').get(),
      }
    end,
  },
}
