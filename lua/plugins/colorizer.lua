local ft = {
  'css',
  'scss',
  'less',
  'svelte',
  'vue',
  'html',
  'xml',
  'json',
  'jsonc',
  'javascriptreact',
  'typescriptreact',
}

return {
  {
    'catgoose/nvim-colorizer.lua',
    ft = ft,
    opts = {
      filetypes = ft,
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        css_fn = true,
        names = false,
        tailwind = true,
      },
    },
  },
}
