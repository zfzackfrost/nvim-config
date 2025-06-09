local wk = require('which-key')

local prefix = '<leader>t'
wk.add({
  { '<Esc><Esc>', [[<C-\><C-n>]], mode = 't' },
  { prefix, group = 'terminal' },
  { prefix .. 'n', [[<Cmd>TermNew<Cr>]], desc = 'Open new terminal' },
  { prefix .. 's', [[<Cmd>TermSelect<Cr>]], desc = 'Select terminal' },
})
