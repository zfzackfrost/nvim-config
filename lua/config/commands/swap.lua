local function plural(word, count)
  if count ~= 1 then
    return word .. 's'
  end
  return word
end

---@param t vim.api.keyset.create_user_command.command_args
local function clean_swap(t)
  local views = vim.fs.find(function()
    return true
  end, { path = vim.go.directory, type = 'file', limit = math.huge })
  local ok_count = 0
  local err_count = 0
  for _, v in ipairs(views) do
    local _, err = vim.uv.fs_unlink(v)
    if err == nil then
      ok_count = ok_count + 1
    else
      err_count = err_count + 1
    end
  end
  if not t.smods.silent and not t.smods.emsg_silent then
    vim.notify(
      string.format(
        'Cleaned %d swap %s\nEncountered %d %s',
        ok_count,
        plural('file', ok_count),
        err_count,
        plural('error', err_count)
      ),
      vim.log.levels.INFO,
      {}
    )
  end
end

nvim.create_user_command('CleanSwap', clean_swap, { bar = true })
