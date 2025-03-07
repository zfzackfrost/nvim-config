local wk = require('which-key')
wk.add({
  { '<leader>x', group = 'list' },
  { '<leader>xx', '<Cmd>Trouble diagnostics toggle<Cr>', desc = 'Diagnostics' },
  { '<leader>xX', '<Cmd>Trouble diagnostics toggle filter.buf=0<Cr>', desc = 'Buffer Diagnostics' },
  { '<leader>xL', '<Cmd>Trouble loclist toggle<Cr>', desc = 'Location list (Trouble)' },
  { '<leader>xQ', '<Cmd>Trouble qflist toggle<Cr>', desc = 'Quickfix list (Trouble)' },
})
