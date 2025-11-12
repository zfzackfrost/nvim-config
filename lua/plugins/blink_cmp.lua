return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'LuaSnip',
      'ribru17/blink-cmp-spell',
    },
    event = { 'InsertEnter' },
    config = function()
      require('config.blink_cmp')
    end,
  },
}
