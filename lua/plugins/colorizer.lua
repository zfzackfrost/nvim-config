local ft = {
  'css',
  'scss',
  'svelte',
  'html',
  'xml',
  'json',
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
        tailwind = 'lsp',
      },
    },
  },
}
