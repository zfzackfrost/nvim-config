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
    opts = { -- set to setup table
      filetypes = ft,
      css = true,
      sass = { enable = true, parsers = { 'css' } }, -- Enable sass colors
    },
  },
}
