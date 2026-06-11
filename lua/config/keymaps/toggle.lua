local wk = require('which-key')
local prefix = [[<leader>\]]

wk.add({
  { prefix, group = 'toggle' },
})
Snacks.toggle.option('spell', { name = 'Spelling' }):map(prefix .. 's')
Snacks.toggle.option('wrap', { name = 'Wrap' }):map(prefix .. 'w')
Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map(prefix .. 'r')
Snacks.toggle.option('number', { name = 'Line Number' }):map(prefix .. 'n')

Snacks.toggle.diagnostics():map(prefix .. 'D')
Snacks.toggle.inlay_hints():map(prefix .. 'H')
