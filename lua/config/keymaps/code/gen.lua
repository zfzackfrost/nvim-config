local wk = require('which-key')
local m = require('utils.vim.map')

local prefix = '<leader>cg'
---@type wk.Icon
local modeline_icon = {
  icon = '',
  color = 'green',
}
wk.add({
  { prefix, group = 'generate', icon = {
    icon = '󰷫',
    color = 'blue',
  } },
  { prefix .. 'b', [[<Cmd>CommentBox<Cr>]], desc = 'Comment box', mode = { 'n', 'v' } },
  { prefix .. 'm', [[<Cmd>GenModeline<Cr>]], desc = 'Modeline', mode = { 'n' }, icon = modeline_icon },
  { prefix .. 'd', m.unimplemented, desc = 'Documentation comment', mode = { 'n', 'v' } },
})
