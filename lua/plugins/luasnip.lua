return {
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    lazy = true,
    build = 'make install_jsregexp',
    ft = { 'snippets' },
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_snipmate').lazy_load()
    end,
  },
}
