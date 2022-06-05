local Path = require('user.utils.fs.path')

return function(s)
  return Path:new(s):parent()
end
