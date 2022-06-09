local M = {}
local placeholder = require('user.utils.placeholder')

M.is_table = function(x)
  return type(x) == 'table'
end

M.is_string = function(x)
  return type(x) == 'string'
end

M.is_function = function(x)
  return type(x) == 'function'
end

M.is_callable = function(x)
  if M.is_function(x) then
    return true
  elseif M.is_table(x) then
    local mt = getmetatable(x)
    return M.is_table(mt) and M.is_function(mt.__call)
  end
  return false
end

M.is_nil = function(x)
  return x == nil
end

M.is_uninit = function(x)
  return M.is_nil(x) or placeholder.is_placeholder(x)
end

return M
