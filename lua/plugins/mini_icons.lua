return {
  {
    'echasnovski/mini.icons',
    version = false,
    lazy = true,
    opts = {
      file = {
        ['init.lua'] = { glyph = '󰢱' },
      },
    },
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
