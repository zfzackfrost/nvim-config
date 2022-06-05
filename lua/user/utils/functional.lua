local M = {}
local F = require('user.utils._fun')

local tbl_reverse = function(t)
  local n = #t
  for i = 1, n do
    t[i], t[n] = t[n], t[i]
    n = n - 1
  end
  return t
end

local tbl_path = function(t, path)
  if type(t) ~= 'table' then
    return t
  end

  local keys = vim.split(path, '.', { plain = true })
  for _, k in ipairs(keys) do
    t = t[k]
    if t == nil then
      return nil
    end
  end
  return t
end

function M.map_path(f, path, ...)
  return F.map(function(v)
    return f(tbl_path(v, path))
  end, ...)
end

function M.if_nil(x, was_nil, was_not_nil)
  if x == nil then
    return was_nil
  else
    return was_not_nil
  end
end

function M.call_all(...)
  local funcs = { ... }
  return function(...)
    local args = { ... }
    F.each(function(x)
      x(unpack(args))
    end, funcs)
  end
end

function M.xform_args(func, xform, ...)
  xform = M.rpartial(xform, ...)
  return function(...)
    return func(unpack(F.totable(F.map(xform, { ... }))))
  end
end

function M.partial(fn, ...)
  local args = { ... }
  return function(...)
    return fn(unpack(args), ...)
  end
end

function M.rpartial(fn, ...)
  local args = tbl_reverse({ ... })
  return function(...)
    return fn(..., unpack(args))
  end
end

function M.find_head(pred, ...)
  local filtered = F.filter(pred, ...)
  return F.is_null(filtered) and nil or F.head(filtered)
end

function M.find_tail(pred, ...)
  local filtered = F.filter(pred, ...)
  return F.is_null(filtered) and nil or F.tail(filtered)
end

return setmetatable(M, {
  __index = F,
})
