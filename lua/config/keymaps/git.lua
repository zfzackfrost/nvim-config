local wk = require('which-key')
wk.add({
  { '<leader>g', group = 'git' },
  { '<leader>gaa', [[<Cmd>Git add --all<Cr>]] },
  { '<leader>gaf', [[<Cmd>Git add %<Cr>]] },
  { '<leader>gc', [[<Cmd>Git commit<Cr>]] },
})
