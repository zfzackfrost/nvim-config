local M = {}

local T = Utils.tbl

M.starts_with = function(s, prefix)
  return s:sub(1, #prefix) == prefix
end

M.ends_with = function(s, suffix)
  return s:sub(-#suffix) == suffix
end

M.strip_prefix = function(s, prefix)
  if M.starts_with(s, prefix) then
    return s:sub(#prefix + 1)
  end
  return s
end

M.strip_suffix = function(s, suffix)
  if M.ends_with(s, suffix) then
    return s:sub(1, -#suffix - 1)
  end
  return s
end

M.split_once = function(s, delim, plain)
  local first, last = string.find(s, delim, 1, plain or false)
  if first == nil then
    return s
  elseif first > 1 and last < #s then
    return string.sub(s, 1, first - 1), string.sub(s, last + 1)
  elseif first == 1 then
    return '', string.sub(s, last + 1)
  elseif last == #s then
    return string.sub(s, 1, first - 1), ''
  end
end

M.split = function(s, delim, opts)
  opts = opts or {}

  local trim_empty = opts.trim_empty or false
  local plain = opts.plain or false

  local tail
  local parts = {}
  local tmp_s = s
  while true do
    local head
    head, tail = M.split_once(tmp_s, delim, plain)
    table.insert(parts, head)
    if tail ~= nil then
      if #tail == 0 then
        break
      else
        tmp_s = tail
      end
    else
      break
    end
  end
  table.insert(parts, tail)

  if trim_empty then
    parts = T.drop_from_start(function(p) return #p == 0 end, parts)
    parts = T.drop_from_end(function(p) return #p == 0 end, parts)
  end

  return parts
end

return M

