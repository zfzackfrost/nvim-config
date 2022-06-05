return function()
  local luasnip = require('luasnip')

  luasnip.config.set_config({})
  luasnip.filetype_extend('all', { '_' })
  require('luasnip.loaders.from_vscode').load({})
end
