local wk = require('which-key')
wk.add({
  { '<leader>t', group = 'tabs' },
  { '<leader>td', '<Cmd>tabclose<Cr>', desc = 'Close current tab' },
  { '<leader>to', '<Cmd>tabonly<Cr>]]', desc = 'Close other tabs' },

  { '<leader>tm', group = 'move tab' },
  { '<leader>tm-', '<Cmd>-tabmove<Cr>]]', desc = 'Move tab left' },
  { '<leader>tm+', '<Cmd>+tabmove<Cr>]]', desc = 'Move tab right' },
  { '<leader>tm0', '<Cmd>0tabmove<Cr>]]', desc = 'Move tab to first' },
  { '<leader>tm$', '<Cmd>$tabmove<Cr>]]', desc = 'Move tab to last' },
})
