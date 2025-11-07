local wk = require('which-key')

local prefix = '<leader>f'
wk.add({
  { prefix, group = 'files' },
  { prefix .. 'p', [[:!mkdir -p %:p:h<Cr>]], desc = 'Make parent directory' },
})
