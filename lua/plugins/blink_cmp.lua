return {
  {
    'saghen/blink.cmp',
    build = 'cargo build --release',
    dependencies = {
      'LuaSnip',
      'MahanRahmati/blink-nerdfont.nvim',
    },
    event = { 'InsertEnter' },
    config = function()
      require('config.blink_cmp')
    end,
  },
}
