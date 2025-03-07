local wk = require('which-key')
wk.add({
  { '<leader>f', group = 'files' },
  { '<leader>fd', [[:!mkdir -p %:p:h<Cr>]], desc = 'Make parent directory' },
})
