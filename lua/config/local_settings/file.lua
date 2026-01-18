local M = {}

---@module 'config.local_settings.types'

local defaults = require('config.local_settings.defaults')

---@return string?
function M.get_file_path()
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

---Get the `.nvim` directory, located next to the `nvim.json`/`.nvim.json` file.
---@return string? # The `.nvim` directory, or nil if it doesn't exist
function M.get_local_dir()
  local settings_file = M.get_file_path()
  if settings_file == nil then
    return
  end
  local local_dir = vim.fs.dirname(settings_file)
  local dir_path = vim.fs.joinpath(local_dir, '.nvim')
  if vim.fn.isdirectory(dir_path) == 1 then
    return dir_path
  end
end

---@return LocalSettings
function M.read_settings()
  local p = M.get_file_path()
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
