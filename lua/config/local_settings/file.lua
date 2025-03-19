local M = {}

local defaults = require('config.local_settings.defaults')

local function get_file_path()
  local path = vim.fn.expand('%:p:h')
  if not vim.uv.fs_stat(path) then
    path = vim.fn.getcwd()
  end
  local files = vim.fs.find({ '.nvim.json', 'nvim.json' }, {
    type = 'file',
    path = path,
    upward = true,
  })
  if #files > 0 then
    return files[1]
  end
end

function M.read_settings()
  local p = get_file_path()
  local d = vim.deepcopy(defaults)
  if p == nil then
    return d
  end
  local f = io.open(p, 'rb')
  if f == nil then
    return d
  end
  local j = f:read('*a')
  f:close()
  local ok, settings = pcall(vim.json.decode, j)
  if ok then
    return vim.tbl_deep_extend('force', d, settings)
  end
  return d
end

return M
