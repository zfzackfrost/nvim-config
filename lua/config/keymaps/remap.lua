local m = require('utils.map')

-- Disable tmux prefix key
m.disable_map('<C-a>')

-- Force `mini.surround` mappings to show with `which-key`
vim.keymap.set({ 'n', 'v' }, 's', function()
  require('which-key').show({
    keys = 's',
  })
end)
