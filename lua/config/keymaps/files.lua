local wk = require('which-key')
wk.add({
  { '<leader>f', group = 'files' },
  { '<leader>fp', [[:!mkdir -p %:p:h<Cr>]], desc = 'Make parent directory' },
  { '<leader>ft', [[<Cmd>Telescope filetypes<Cr>]], desc = 'Set filetype' },
})
