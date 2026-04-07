return {
  {
    'nvim-mini/mini.icons',
    version = false,
    lazy = true,
    opts = function()
      local opts = {
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
          ['.env'] = { glyph = '', hl = 'MiniIconsGrey' },
        },
        extension = {
          ['env'] = { glyph = '', hl = 'MiniIconsGrey' },
          ['snippets'] = { glyph = '󱄽', hl = 'MiniIconsGrey' },
          ['lua'] = { glyph = '󰢱', hl = 'MiniIconsAzure' },
          ['glsl'] = { glyph = '', hl = 'MiniIconsYellow' },
          ['hlsl'] = { glyph = '', hl = 'MiniIconsYellow' },
          ['wgsl'] = { glyph = '', hl = 'MiniIconsYellow' },
          ['blend'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['gltf'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['glb'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['dae'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['fbx'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['3ds'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['obj'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['mat'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['vdb'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['abc'] = { glyph = '󱗾', hl = 'MiniIconsOrange' },
          ['stl'] = { glyph = '󰹛', hl = 'MiniIconsOrange' },
          ['3mf'] = { glyph = '󰹛', hl = 'MiniIconsOrange' },
          ['usd'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['usda'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['usdc'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['usdz'] = { glyph = '', hl = 'MiniIconsOrange' },
          ['scad'] = { glyph = '󰺾', hl = 'MiniIconsBlue' },
          ['step'] = { glyph = '󰺾', hl = 'MiniIconsBlue' },
          ['dxf'] = { glyph = '󰺾', hl = 'MiniIconsBlue' },
          ['spi'] = { glyph = '', hl = 'MiniIconsGreen' },
          ['cir'] = { glyph = '', hl = 'MiniIconsGreen' },
          ['ckt'] = { glyph = '', hl = 'MiniIconsGreen' },
          ['libs'] = { glyph = '', hl = 'MiniIconsGreen' },
          ['mod'] = { glyph = '', hl = 'MiniIconsGreen' },
          ['inc'] = { glyph = '', hl = 'MiniIconsGreen' },
          ['sub'] = { glyph = '', hl = 'MiniIconsGreen' },
        },
      }
      --Add Blender backup extensions
      for i = 1, 64, 1 do
        opts.extension['blend' .. tostring(i)] = {
          glyph = opts.extension['blend'].glyph,
          hl = 'MiniIconsDarkGrey',
        }
      end
      return opts
    end,
    config = function(_, opts)
      require('mini.icons').setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
}
