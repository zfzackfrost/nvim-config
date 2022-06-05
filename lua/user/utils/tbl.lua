local M = {}
local F = Utils.functional

-- Credit: https://www.lua.org/pil/13.4.5.html
M.read_only = function(t)
  local proxy = {}
  local mt = {
    __index = t,
    __newindex = function(_, _, _)
      error('Attempting to upate a read-only table', 2)
    end,
  }
  setmetatable(proxy, mt)
  return proxy
end

M.map_kv = function(t, func)
  local out = {}
  for k, v in pairs(t) do
    local k2, v2 = func(k, v)
    out[k2] = v2
  end
  return out
end

function M.drop_from_start(pred, t)
  return F.totable(F.drop_while(pred, t))
end
function M.drop_from_end(pred, t)
  local rev = M.reverse_copy(t)
  return M.reverse(F.totable(F.drop_while(pred, rev)))
end

M.reverse = function(t)
  local n = #t
  for i = 1, n do
    t[i], t[n] = t[n], t[i]
    n = n - 1
  end
  return t
end

M.reverse_copy = function(t)
  local rev = {}
  for i = #t, 1, -1 do
    rev[#rev + 1] = t[i]
  end
  return rev
end

M.get = function(t, keys)
  return vim.tbl_get(t, unpack(keys))
end


M.is_list = function(t)
  return vim.tbl_islist(t)
end

M.flatten = function(t)
  return vim.tbl_flatten(t)
end

M.concat = function(t1, t2)
  return {unpack(t1), unpack(t2)}
end

return M
