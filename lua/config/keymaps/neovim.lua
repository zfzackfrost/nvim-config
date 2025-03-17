local wk = require('which-key')
wk.add({
  { '<leader>v', group = '(neo)vim' },
  { '<leader>vv', [[<Cmd>CleanViews<Cr>]], desc = 'Clean views' },

  { '<leader>vs', group = 'server' },
  { '<leader>vss', [[<Cmd>StartServer<Cr>]], desc = 'Start server' },
  { '<leader>vse', [[<Cmd>StopServer<Cr>]], desc = 'Stop Server' },
  { '<leader>vsd', [[<Cmd>CleanServerPipe<Cr>]], desc = 'Clean old server pipe' },
})
