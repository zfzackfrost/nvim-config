local m = Utils.map

_G.UserMap = _G.UserMap or {}
_G.UserMap.search = _G.UserMap.search or {}
_G.UserMap.search.escaped_selection = function()
  local vs = require('user.utils.vim').get_visual_selection()
  return vim.fn.escape(vs, '^$.*?/\\[]')
end

m.group_name('n', '<Space>s', 'search')

m.map('n', '<Space>r', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>', { silent = false, desc = 'Replace cursor word' })
m.map(
  'v',
  '<Space>r',
  ':<C-u>%s/<C-r>=v:lua.UserMap.search.escaped_selection()<Cr>//g<Left><Left>',
  { silent = false, desc = 'Replace selected' }
)
