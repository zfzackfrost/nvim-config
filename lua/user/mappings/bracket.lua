local m = Utils.map
local g_at_space = m.tc('g@<Space>')

_G.UserMap = _G.UserMap or {}
_G.UserMap.bracket = _G.UserMap.bracket or {}

_G.UserMap.bracket.ins_empty_above = function(mode)
  if mode ~= nil then
    vim.cmd([[put! =repeat(nr2char(10), v:count1)]])
    vim.cmd([[ ']+1 ]])
  else
    vim.go.operatorfunc = 'v:lua.UserMap.bracket.ins_empty_above'
    return g_at_space
  end
end

_G.UserMap.bracket.ins_empty_below = function(mode)
  if mode ~= nil then
    vim.cmd([[put =repeat(nr2char(10), v:count1)]])
    vim.cmd([[ '[-1 ]])
  else
    vim.go.operatorfunc = 'v:lua.UserMap.bracket.ins_empty_below'
    return g_at_space
  end
end

local function exec_move(cmd)
  local old_fdm = vim.wo.foldmethod
  if old_fdm ~= 'manual' then
    vim.wo.foldmethod = 'manual'
  end
  vim.cmd([[normal! m`]])
  vim.fn.execute(cmd, 'silent!')
  vim.cmd([[normal! ``]])
  if old_fdm ~= 'manual' then
    vim.wo.foldmethod = old_fdm
  end
end

_G.UserMap.bracket.move_up = function(mode)
  if mode ~= nil then
    local count = vim.v.count1
    exec_move([[move--]] .. tostring(count))
  else
    vim.go.operatorfunc = 'v:lua.UserMap.bracket.move_up'
    return g_at_space
  end
end

_G.UserMap.bracket.move_down = function(mode)
  if mode ~= nil then
    local count = vim.v.count1
    exec_move([[move+]] .. tostring(count))
  else
    vim.go.operatorfunc = 'v:lua.UserMap.bracket.move_down'
    return g_at_space
  end
end
_G.UserMap.bracket.move_selected_lines_up = function(mode)
  if mode ~= nil then
    local count = vim.v.count1
    exec_move([['<,'>move'<--]] .. tostring(count))
  else
    vim.go.operatorfunc = 'v:lua.UserMap.bracket.move_selected_lines_up'
    return g_at_space
  end
end

_G.UserMap.bracket.move_selected_lines_down = function(mode)
  if mode ~= nil then
    local count = vim.v.count1
    exec_move([['<,'>move'>+]] .. tostring(count))
  else
    vim.go.operatorfunc = 'v:lua.UserMap.bracket.move_selected_lines_down'
    return g_at_space
  end
end

m.map('n', '[<Space>', 'v:lua.UserMap.bracket.ins_empty_above()', { expr = true, desc = 'Insert line above' })
m.map('n', ']<Space>', 'v:lua.UserMap.bracket.ins_empty_below()', { expr = true, desc = 'Insert line below' })

m.map('n', '[e', 'v:lua.UserMap.bracket.move_up()', { expr = true, desc = 'Move line up' })
m.map('n', ']e', 'v:lua.UserMap.bracket.move_down()', { expr = true, desc = 'Move line down' })
m.map('x', '[e', 'v:lua.UserMap.bracket.move_selected_lines_up()', { expr = true, desc = 'Move selection up' })
m.map('x', ']e', 'v:lua.UserMap.bracket.move_selected_lines_down()', { expr = true, desc = 'Move selection down' })

