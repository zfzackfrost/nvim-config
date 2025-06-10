local wk = require('which-key')
local prefix = '<leader>k'

---@type wk.Icon
local tasks_icon = {
  icon = '󱤵',
  color = 'orange',
}

wk.add({
  { prefix, group = 'tasks', icon = tasks_icon },
  { prefix .. 'k', [[<Cmd>OverseerToggle bottom<Cr>]], desc = 'Toggle tasks window', icon = tasks_icon },
  { prefix .. 't', [[<Cmd>OverseerRun<Cr>]], desc = 'Run task from template', icon = tasks_icon },
  { prefix .. 'b', [[<Cmd>OverseerBuild<Cr>]], desc = 'Open task builder', icon = tasks_icon },
})
