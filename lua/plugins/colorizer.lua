local ft = {
  'css',
  'scss',
  'svelte',
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
