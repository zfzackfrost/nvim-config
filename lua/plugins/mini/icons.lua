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
        ['.nvim.json'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['nvim.json'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['lazy-lock.json'] = { glyph = '󱌠', hl = 'MiniIconsRed' },
        ['pnpm-lock.yaml'] = { glyph = '󱌠', hl = 'MiniIconsRed' },
        ['package-lock.json'] = { glyph = '󱌠', hl = 'MiniIconsRed' },
        ['Cargo.lock'] = { glyph = '󱌠', hl = 'MiniIconsRed' },
        ['init.lua'] = { glyph = '󰢱', hl = 'MiniIconsAzure' },
        ['package.json'] = { glyph = '', hl = 'MiniIconsRed' },
        ['.prettierrc'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['vite.config.js'] = { glyph = '', hl = 'MiniIconsBlue' },
        ['vite.config.ts'] = { glyph = '', hl = 'MiniIconsBlue' },
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
