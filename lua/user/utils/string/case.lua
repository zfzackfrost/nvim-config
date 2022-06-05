local M = {}

local F = Utils.functional
local S = Utils.string

M.upper_first = function(s)
  if #s == 0 then
    return s
  end
  return string.sub(s, 1, 1):upper() .. (#s >= 1 and string.sub(s, 2) or '')
end

M.snake_to_pascal = function(s)
  local parts = F.map(M.upper_first, S.split(s, '_', {plain = true}))
  if F.is_null(parts) then
    return ''
  end
  return F.foldl(F.op.concat, F.head(parts), F.drop_n(1, parts))
end

M.pascal_to_snake = function(s)
  return s:gsub(".%f[%l]", "%1"):gsub("%l%f[%u%d]", "%1_"):lower()
end

return M
