local m = require('utils.map')

m.disable_map('<C-a>')
vim.keymap.set({ 'n', 'v' }, 's', function()
  require('which-key').show({
    keys = 's',
  })
end)
