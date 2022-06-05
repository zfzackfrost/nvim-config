local M = {}
local S = Utils.string
local Fs = Utils.fs

M.config = M.config or {}
M.config.max_depth = M.config.max_depth or 10
M.config.markers = M.config.markers or {
  { marker = '.nvim-project', directory = true },
  { marker = '.git', directory = true },
  { marker = 'Cargo.lock', file = true },
  { marker = 'Cargo.toml', file = true },
  { marker = 'CMakeLists.txt', file = true },
  { marker = 'package.json', file = true },
}

local function buffer_path(bufnr)
  return Fs.Path:new(vim.api.nvim_buf_get_name(bufnr or 0))
end

M.get_mark_file = function(mark)
  local status_ok, m = pcall(vim.api.nvim_exec, ([[marks %s]]):format(mark), true)
  if not status_ok then
    return ''
  end
  local f
  do
    local lines = vim.split(m, '\n', { plain = true })
    local l = vim.split(lines[#lines], '%s+', {})
    f = l[#l]
  end
  return Fs.is_file(f) and f or ''
end

M.get_full_name = function(f)
  f = f or ''
  f = f:find([[^'.$]]) and M.get_mark_file(f:sub(2, 2)) or f
  f = (#f > 0) and f or buffer_path()
  return Fs.Path:new(f):absolute()
end

M.get = function(file)
  local full_file = M.get_full_name(file)
  if vim.b.project_root ~= nil then
    local abs_full_file = Fs.Path:new(vim.b.project_root):absolute()
    if S.starts_with(full_file, abs_full_file) then
      return vim.b.project_root
    end
  end
  if S.starts_with(full_file, 'fugitive:/') then
    if vim.b.git_dir ~= nil then
      return tostring(Fs.Path:new(vim.b.git_dir):parent())
    end
    return ''
  end

  for _, m in ipairs(M.config.markers) do
    local pivot = Fs.Path:new(Fs.Path:new(full_file):absolute())

    local marker = m.marker
    local allow_dir = m.directory or false
    local allow_file = m.file or false

    local depth = 0
    while depth < M.config.max_depth do
      depth = depth + 1

      local prev = pivot
      pivot = pivot:parent()
      local f = pivot / marker

      local file_ok = allow_file and f:is_file() or false
      local dir_ok = allow_dir and f:is_dir() or false
      if file_ok or dir_ok then
        return tostring(pivot)
      end
      if pivot == prev then
        break
      end
    end
  end
  return ''
end

M.guess = function(file)
  local proj_root = M.get(file)
  if #proj_root > 0 then
    return proj_root
  end
  local full_file = M.get_full_name(file)
  local p = (not Fs.is_dir(full_file)) and Fs.parent(full_file) or full_file
  return tostring(p)
end

return M
