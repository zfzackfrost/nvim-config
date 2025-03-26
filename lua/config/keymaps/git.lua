local wk = require('which-key')

local prefix = '<leader>g'
local prefix_add = prefix .. 'a'
local prefix_commit = prefix .. 'c'

---@type wk.Icon
local git_icon = {
  icon = '',
  color = 'red',
}
wk.add({
  { prefix, group = 'git' },

  { prefix_add, group = 'add', icon = git_icon },
  { prefix_add .. 'a', [[<Cmd>Git add --all<Cr>]], desc = 'Add all', icon = git_icon },
  { prefix_add .. 'f', [[<Cmd>Git add %<Cr>]], desc = 'Add current file', icon = git_icon },

  { prefix_commit, group = 'commit', icon = git_icon },
  { prefix_commit .. 'c', [[<Cmd>Git commit<Cr>]], desc = 'Commit', icon = git_icon },
})
