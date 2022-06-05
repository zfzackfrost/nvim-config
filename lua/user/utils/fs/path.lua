local F = Utils.functional

local Path = require('plenary.path')

Path.join = function(...)
  local parts = {...}
  local first = Path:new(parts[1])
  local rest = F.map(Path.new, F.drop(1, parts))
  return tostring(F.foldl(F.operator.div, first, rest))
end

Path.first_existing_file = function(paths)
  local filter_paths = F.filter(Path.is_file, F.map(Path.new, paths))
  if F.is_null(filter_paths) then
    return nil
  else
    return tostring(F.head(filter_paths))
  end
end

Path.first_existing_dir = function(paths)
  local filter_paths = F.filter(Path.is_dir, F.map(Path.new, paths))
  if F.is_null(filter_paths) then
    return nil
  else
    return tostring(F.head(filter_paths))
  end
end

Path.first_existing = function(paths)
  local filter_paths = F.filter(Path.exists, F.map(Path.new, paths))
  if F.is_null(filter_paths) then
    return nil
  else
    return tostring(F.head(filter_paths))
  end
end

return Path
