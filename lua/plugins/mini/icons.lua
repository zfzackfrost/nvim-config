return {
  {
    'nvim-mini/mini.icons',
    version = false,
    lazy = true,
    opts = {
      directory = {
        ['.nvim'] = { glyph = '' },
        ['snippets'] = { glyph = '', hl = 'MiniIconsGrey' },
      },
      file = {
        ['init.lua'] = { glyph = '󰢱' },
      },
      extension = {
        ['snippets'] = { glyph = '' },
      },
    },
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
