local wk = require('which-key')

local prefix = '<leader>g'
local prefix_add = prefix .. 'a'
local prefix_commit = prefix .. 'c'

---@type wk.Icon
local git_icon = {
  icon = '',
  color = 'red',
}

local function lazygit_open()
  ---@diagnostic disable-next-line: missing-fields
  Snacks.lazygit.open({
    configure = true,
  })
end

wk.add({
  { prefix, group = 'git' },

  { prefix .. 'g', lazygit_open, desc = 'Lazygit Open', icon = git_icon },

  { prefix_add, group = 'add', icon = git_icon },
  { prefix_add .. 'a', [[<Cmd>Git add --all<Cr>]], desc = 'Add all', icon = git_icon },
  { prefix_add .. 'f', [[<Cmd>Git add %<Cr>]], desc = 'Add current file', icon = git_icon },

  { prefix_commit, group = 'commit', icon = git_icon },
  { prefix_commit .. 'c', [[<Cmd>Git commit<Cr>]], desc = 'Commit', icon = git_icon },
})
