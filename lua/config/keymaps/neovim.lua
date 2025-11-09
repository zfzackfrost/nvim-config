local wk = require('which-key')

local prefix = '<leader>v'
local prefix_maintain = prefix .. 'm'
local prefix_server = prefix .. 's'

---@type wk.Icon
local vim_icon = {
  icon = '',
  color = 'green',
}

wk.add({
  { '<leader>v', group = '(neo)vim', icon = vim_icon },
  { prefix_maintain, group = 'maintain' },
  { prefix_maintain .. 'v', [[<Cmd>CleanViews<Cr>]], desc = 'Remove all views' },
  { prefix_maintain .. 's', [[<Cmd>CleanSwap<Cr>]], desc = 'Remove all swap files' },

  { prefix_server, group = 'server' },
  { prefix_server .. 's', [[<Cmd>StartServer<Cr>]], desc = 'Start server' },
  { prefix_server .. 'e', [[<Cmd>StopServer<Cr>]], desc = 'Stop server' },
  { prefix_server .. 'd', [[<Cmd>CleanServerPipe<Cr>]], desc = 'Clean old server pipe' },
})
