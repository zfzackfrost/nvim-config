local wk = require('which-key')

local prefix = '<leader>v'
local prefix_maintain = prefix .. 'm'
local prefix_server = prefix .. 's'

---@type wk.Icon
local vim_icon = {
  icon = '',
  color = 'green',
}
---@type wk.Icon
local maintain_icon = {
  icon = ' ',
  color = 'grey',
}
---@type wk.Icon
local remove_icon = {
  icon = ' ',
  color = 'red',
}

wk.add({
  { '<leader>v', group = '(neo)vim', icon = vim_icon },
  { prefix_maintain, group = 'maintain', icon = maintain_icon },
  { prefix_maintain .. 'v', [[<Cmd>CleanViews<Cr>]], desc = 'Remove all views', icon = remove_icon },
  { prefix_maintain .. 's', [[<Cmd>CleanSwap<Cr>]], desc = 'Remove all swap files', icon = remove_icon },

  { prefix_server, group = 'server' },
  { prefix_server .. 's', [[<Cmd>StartServer<Cr>]], desc = 'Start server' },
  { prefix_server .. 'e', [[<Cmd>StopServer<Cr>]], desc = 'Stop server' },
  { prefix_server .. 'd', [[<Cmd>CleanServerPipe<Cr>]], desc = 'Clean old server pipe' },
})
