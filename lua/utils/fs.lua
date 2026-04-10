local M = {}

---Delete all files/subdirectories in the specified directory.
---@param dir_path string path of the directory to operate on
---@param silent boolean? If falsey, display a notification on completion.
---@param notify_formatter (fun(file_count: integer, dir_count: integer, err_count: integer): string)? # Function to create completed notification message. If not provided, a generic message will be used.
function M.clear_dir(dir_path, silent, notify_formatter)
  local file_count = 0
  local dir_count = 0
  local err_count = 0

  local it = vim
    .iter(vim.fs.dir(dir_path))
    :filter(function(_, t)
      return t == 'directory' or t == 'file'
    end)
    :map(function(name, ty)
      return vim.fs.joinpath(dir_path, name), ty
    end)
  for p, ty in it do
    local ok, _ = pcall(vim.fs.rm, p, { recursive = true, force = true })
    if not ok then
      err_count = err_count + 1
    elseif ty == 'file' then
      file_count = file_count + 1
    elseif ty == 'directory' then
      dir_count = dir_count + 1
    end
  end

  if not silent then
    local msg
    if notify_formatter ~= nil then
      msg = notify_formatter(file_count, dir_count, err_count)
    else
      msg = string.format(
        'Removed %d %s and %d %s\nEncountered %d %s',
        file_count,
        utils.func.iff(file_count == 1, 'file', 'files'),
        dir_count,
        utils.func.iff(dir_count == 1, 'directory', 'directories'),
        err_count,
        utils.func.iff(err_count == 1, 'error', 'errors')
      )
    end
    vim.notify(msg, vim.log.levels.INFO, {})
  end
end

---@param path string path to the file to create
---@param perms integer? permissions for the new file; defaults to 438 (644 octal)
function M.create_file(path, perms)
  perms = utils.func.iff(perms == nil, 438, perms --[[@as integer]])
  local fd, err = vim.uv.fs_open(path, 'a', perms)
  if not fd then
    error('failed to create new file: ' .. err)
  end
  vim.uv.fs_close(fd)
end

---Create a directory and its parents
---@param path string path to directory to create
---@param mode? integer Unix-style permission flags (defaults to 755 octal)
---@return boolean # `true` if `path` and its parent directories were created. Otherwise, the function terminated with an error.
function M.mkdirp(path, mode)
  mode = mode or 0x1ED -- 0755

  -- Try the fast path first (directory may already exist)
  local ok, err, code = vim.uv.fs_mkdir(path, mode)
  if ok then
    return true
  end
  if code == 'EEXIST' then
    return true
  end

  if code == 'ENOENT' then
    -- Walk up and create the parent first
    local parent = vim.fs.dirname(path)
    if not parent then
      error('mkdirp failed: could not find parent directory')
    end

    M.mkdirp(parent, mode)

    -- Retry now that parent exists
    local ok2, err2, code2 = vim.uv.fs_mkdir(path, mode)
    if not ok2 and code2 ~= 'EEXIST' then
      error('mkdirp failed: ' .. err2)
    end
    return true
  end

  error('mkdirp failed: ' .. err)
end

return M
