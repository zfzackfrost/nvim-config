local M = {}
local lpeg = require('lpeg')
local F = require('user.utils.functional')

M.glob_to_lpeg = function(glob_pattern)
  local wild = (1 - lpeg.S('./\\')) ^ 0
  local parts = {}
  local s = ''
  F.each(function(ch)
    if ch ~= '*' then
      s = s .. ch
    else
      table.insert(parts, s)
      table.insert(parts, wild)
      s = ''
    end
  end, F.iter(glob_pattern))
  table.insert(parts, s)

  local mapped_parts = F.map(lpeg.P, parts)
  local p = F.foldl(F.op.mul, F.nth(1, mapped_parts), F.drop_n(1, mapped_parts)) * -1
  return lpeg.P({ p + 1 * lpeg.V(1) })
end

return M
