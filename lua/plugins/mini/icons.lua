return {
  {
    'nvim-mini/mini.icons',
    version = false,
    lazy = true,
    opts = {
      lsp = {
        ['snippet'] = { glyph = '󱄽' },
        ['function'] = { glyph = '󰡱' },
        ['method'] = { glyph = '󰊕' },
        ['field'] = { glyph = '' },
        ['variable'] = { glyph = '󰫧' },
      },
      directory = {
        ['.nvim'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['snippets'] = { glyph = '󱄽', hl = 'MiniIconsGrey' },
      },
      file = {
        ['.nvim.json'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['nvim.json'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['lazy-lock.json'] = { glyph = '󱌠', hl = 'MiniIconsDarkGrey' },
        ['pnpm-lock.yaml'] = { glyph = '󱌠', hl = 'MiniIconsDarkGrey' },
        ['package-lock.json'] = { glyph = '󱌠', hl = 'MiniIconsDarkGrey' },
        ['Cargo.lock'] = { glyph = '󱌠', hl = 'MiniIconsDarkGrey' },
        ['init.lua'] = { glyph = '󰢱', hl = 'MiniIconsBlue' },
        ['package.json'] = { glyph = '', hl = 'MiniIconsRed' },
        ['.prettierrc'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['vite.config.js'] = { glyph = '', hl = 'MiniIconsBlue' },
        ['vite.config.ts'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
      extension = {
        ['snippets'] = { glyph = '󱄽', hl = 'MiniIconsGrey' },
        ['lua'] = { glyph = '󰢱', hl = 'MiniIconsAzure' },
        ['glsl'] = { glyph = '', hl = 'MiniIconsYellow' },
        ['hlsl'] = { glyph = '', hl = 'MiniIconsYellow' },
        ['wgsl'] = { glyph = '', hl = 'MiniIconsYellow' },
      },
    },
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
