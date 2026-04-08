local M = {}

M.unpack = table.unpack or unpack
M.pack = table.pack or function(...)
    return { n = select('#', ...), ... }
end

return M
