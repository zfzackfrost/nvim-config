return {
  {
    'nvim-mini/mini.icons',
    version = false,
    lazy = true,
    opts = {
      directory = {
        ['.nvim'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['snippets'] = { glyph = '', hl = 'MiniIconsGrey' },
      },
      file = {
        ['init.lua'] = { glyph = '󰢱', hl = 'MiniIconsAzure' },
      },
      extension = {
        ['snippets'] = { glyph = '', hl = 'MiniIconsGrey' },
        ['lua'] = { glyph = '󰢱', hl = 'MiniIconsAzure' },
      },
    },
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
