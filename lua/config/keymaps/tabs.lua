local wk = require('which-key')
local prefix = '<leader>T'
wk.add({
  { prefix, group = 'tabs' },
  { prefix .. 'd', '<Cmd>tabclose<Cr>', desc = 'Close current tab' },
  { prefix .. 'o', '<Cmd>tabonly<Cr>]]', desc = 'Close other tabs' },

  { prefix .. 'm', group = 'move tab' },
  { prefix .. 'm-', '<Cmd>-tabmove<Cr>]]', desc = 'Move tab left' },
  { prefix .. 'm+', '<Cmd>+tabmove<Cr>]]', desc = 'Move tab right' },
  { prefix .. 'm0', '<Cmd>0tabmove<Cr>]]', desc = 'Move tab to first' },
  { prefix .. 'm$', '<Cmd>$tabmove<Cr>]]', desc = 'Move tab to last' },
})
