local M = {}
local placeholder = require('user.utils.placeholder')

M.is_callable = function(x)
  if type(x) == 'function' then
    return true
  elseif type('x') == 'table' then
    local mt = getmetatable(x)
    return type(mt) == 'table' and type(mt.__call) == 'function'
  end
  return false
end

M.value_is_uninit = function(x)
  if x == nil then
    return true
  end
  if placeholder.is_placeholder(x) then
    return true
  end
  return false
end

return M
