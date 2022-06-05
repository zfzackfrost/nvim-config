local Placeholder = {
  __tostring = function()
    return '<No Value>'
  end
}

local M = {}
M.new = function()
  return setmetatable({}, Placeholder)
end
M.is_placeholder = function(t)
  if type(t) ~= 'table' then
    return false
  end
  return getmetatable(t) == Placeholder
end

return setmetatable({}, {
  __index = M,
  __call =  function(_)
    return M.new()
  end
})
