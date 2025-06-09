local wk = require('which-key')
local prefix = '<leader>l'
wk.add({
  { prefix, group = 'list' },
  { prefix .. 'x', '<Cmd>Trouble diagnostics toggle<Cr>', desc = 'Diagnostics' },
  { prefix .. 'X', '<Cmd>Trouble diagnostics toggle filter.buf=0<Cr>', desc = 'Buffer Diagnostics' },
  { prefix .. 'l', '<Cmd>Trouble loclist toggle<Cr>', desc = 'Location list (Trouble)' },
  { prefix .. 'q', '<Cmd>Trouble qflist toggle<Cr>', desc = 'Quickfix list (Trouble)' },
})
