local M = {}

local F = Utils.functional

M.Path = require('user.utils.fs.path')

local uv = vim.loop

local function tree_impl(accum, dir)
  local nodes = F.map(function(v)
    v = dir .. '/' .. v
    if vim.fn.isdirectory(v) > 0 then
      return tree_impl(accum, v)
    else
      return v
    end
  end, vim.fn.readdir(dir))
  F.each(F.partial(table.insert, accum), nodes)
end

local function read_file_sync(filename)
  local fd = assert(uv.fs_open(tostring(M.Path:new(filename):expand()), 'r', 438))
  local stat = assert(uv.fs_fstat(fd))
  local data = assert(uv.fs_read(fd, stat.size, 0))
  assert(uv.fs_close(fd))
  return data
end
local function read_file_async(filename, callback)
  vim.loop.fs_open(tostring(M.Path:new(filename):expand()), 'r', 438, function(err_open, fd)
    if err_open then
      error('Failed to open file for reading. Got error message: ' .. err_open, 3)
      return
    end
    vim.loop.fs_fstat(fd, function(err_fstat, stat)
      assert(not err_fstat, err_fstat)
      if stat.type ~= 'file' then
        return callback('')
      end
      vim.loop.fs_read(fd, stat.size, 0, function(err_read, data)
        assert(not err_read, err_read)
        vim.loop.fs_close(fd, function(err_close)
          assert(not err_close, err_close)
          return callback(data)
        end)
      end)
    end)
  end)
end

M.sep = (function()
  if jit then
    local os = string.lower(jit.os)
    if os == 'linux' or os == 'osx' or os == 'bsd' then
      return '/'
    else
      return '\\'
    end
  else
    return package.config:sub(1, 1)
  end
end)()

M.read_file = function(filename, callback)
  if callback then
    return read_file_async(filename, callback)
  end
  return read_file_sync(filename)
end

M.tree = function(dir)
  local accum = {}
  tree_impl(accum, dir)
  return accum
end

M.is_file = function(path)
  return M.Path:new(path):is_file()
end

M.is_dir = function(path)
  return M.Path:new(path):is_dir()
end

M.parent = function(path)
  return tostring(M.Path:new(path):parent())
end

M.get_cwd = function()
  return uv.fs_realpath('.')
end
M.get_home_dir = function()
  return uv.os_homedir()
end

return M
