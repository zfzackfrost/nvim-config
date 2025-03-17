local wk = require('which-key')

local prefix = '<leader>cg'
wk.add({
  { prefix, group = 'generate', icon = {
    icon = '󰷫',
    color = 'blue',
  } },
  { prefix .. 'b', [[<Cmd>CommentBox<Cr>]], desc = 'Generate comment box', mode = { 'n', 'v' } },
})
