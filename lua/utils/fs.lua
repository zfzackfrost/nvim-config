local M = {}

---Delete all files/subdirectories in the specified directory.
---@param dir_path string path of the directory to operate on
---@param silent boolean? If falsey, display a notification on completion.
function M.clear_dir(dir_path, silent)
  local files = vim.fs.find(function()
    return true
  end, { path = dir_path, limit = math.huge })

  local ok_count = 0
  local err_count = 0
  for _, f in ipairs(files) do
    local _, err = vim.uv.fs_unlink(f)
    if err == nil then
      ok_count = ok_count + 1
    else
      err_count = err_count + 1
    end
  end
  if not silent then
    vim.notify(
      string.format(
        'Removed %d %s\nEncountered %d %s',
        ok_count,
        utils.func.iff(ok_count == 1, 'file', 'files'),
        err_count,
        utils.func.iff(err_count == 1, 'error', 'errors')
      ),
      vim.log.levels.INFO,
      {}
    )
  end
end

---@param path string path to the file to create
---@param perms integer? permissions for the new file; defaults to 438 (644 octal)
function M.create_file(path, perms)
  perms = utils.func.iff(perms == nil, 438, perms)
  local fd, err = vim.uv.fs_open(path, 'a', perms)
  if not fd then
    error('failed to create new file: ' .. err)
  end
  vim.uv.fs_close(fd)
end

return M
