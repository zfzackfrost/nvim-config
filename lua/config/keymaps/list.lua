local wk = require('which-key')
local prefix = '<leader>l'

---@type wk.Icon
local list_icon = {
  icon = ' ',
  color = 'azure',
}
---@type wk.Icon
local diagnostics_icon = {
  icon = '󱖫',
  color = 'yellow',
}
---@type wk.Icon
local messages_icon = {
  icon = '󰍡',
  color = 'red',
}
wk.add({
  { prefix, group = 'list', icon = list_icon },
  {
    prefix .. 'm',
    '<Cmd>Noice<Cr>',
    desc = 'Messages',
    icon = messages_icon,
  },
  {
    prefix .. 'x',
    '<Cmd>Trouble diagnostics toggle<Cr>',
    desc = 'Diagnostics',
    icon = diagnostics_icon,
  },
  {
    prefix .. 'X',
    '<Cmd>Trouble diagnostics toggle filter.buf=0<Cr>',
    desc = 'Buffer Diagnostics',
    icon = diagnostics_icon,
  },
  { prefix .. 'l', '<Cmd>Trouble loclist toggle<Cr>', desc = 'Location list (Trouble)' },
  { prefix .. 'q', '<Cmd>Trouble qflist toggle<Cr>', desc = 'Quickfix list (Trouble)' },
})
