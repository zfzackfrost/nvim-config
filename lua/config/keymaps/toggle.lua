local wk = require('which-key')
local prefix = [[\]]

wk.add({
  { prefix, group = 'toggle' },
  { prefix .. [[\]], 'za', desc = 'Toggle fold under cursor' },
  { prefix .. '<Space>', 'zA', desc = 'Toggle all folds under cursor' },
})
Snacks.toggle.option('spell', { name = 'Spelling' }):map(prefix .. 'u')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map(prefix .. 'w')
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map(prefix .. 'r')
Snacks.toggle.option('number', { name = 'Line Number' }):map(prefix .. 'n')

Snacks.toggle.diagnostics():map(prefix .. 'D')
Snacks.toggle.inlay_hints():map(prefix .. 'H')
