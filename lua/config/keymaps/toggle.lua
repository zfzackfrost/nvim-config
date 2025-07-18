local wk = require('which-key')
local prefix = [[\]]

wk.add({
  { prefix, group = 'toggle' },
  { prefix .. [[\]], 'za', desc = 'Toggle fold under cursor' },
  { prefix .. '<Space>', 'zA', desc = 'Toggle all folds under cursor' },
})
