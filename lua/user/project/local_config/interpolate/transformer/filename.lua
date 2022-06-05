local Path = require('user.utils.fs.path')
return function(s)
  local dir = Path:new(s):parent()
  return Path:new(s):make_relative(tostring(dir))
end
