return {
  {
    'saghen/blink.cmp',
    build = 'cargo build --release',
    dependencies = { 'LuaSnip' },
    event = { 'InsertEnter' },
    config = function()
      require('config.blink_cmp')
    end,
  },
}
