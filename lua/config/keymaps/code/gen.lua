local wk = require('which-key')
local m = require('utils.vim.map')

local prefix = '<leader>cg'
wk.add({
  { prefix, group = 'generate', icon = {
    icon = '󰷫',
    color = 'blue',
  } },
  { prefix .. 'b', [[<Cmd>CommentBox<Cr>]], desc = 'Comment box', mode = { 'n', 'v' } },
  { prefix .. 'd', m.unimplemented, desc = 'Documentation comment', mode = { 'n', 'v' } },
})
