local wk = require('which-key')

local prefix = '<leader>v'
local prefix_maintain = prefix .. 'm'
local prefix_server = prefix .. 's'
wk.add({
  { '<leader>v', group = '(neo)vim' },
  { prefix_maintain, group = 'maintain' },
  { prefix_maintain .. 'v', [[<Cmd>CleanViews<Cr>]], desc = 'Remove all views' },

  { prefix_server, group = 'server' },
  { prefix_server .. 's', [[<Cmd>StartServer<Cr>]], desc = 'Start server' },
  { prefix_server .. 'e', [[<Cmd>StopServer<Cr>]], desc = 'Stop Server' },
  { prefix_server .. 'd', [[<Cmd>CleanServerPipe<Cr>]], desc = 'Clean old server pipe' },
})
