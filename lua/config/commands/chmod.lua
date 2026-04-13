---@param t vim.api.keyset.create_user_command.command_args
local function chmod(t)
  local perms = t.fargs[1]
  local file = t.fargs[2]
  if file == nil then
    if vim.bo.buftype ~= '' then
      vim.notify('Buffer is not associated with a file', vim.log.levels.ERROR)
      return
    end
    file = '%'
  end
  file = vim.fn.expandcmd(file)
  if vim.uv.fs_stat(file) == nil then
    vim.notify(("Not found\n  '%s'"):format(file), vim.log.levels.ERROR)
    return
  end
  file = vim.fs.abspath(file)
  vim.system({ 'chmod', perms, file }, { text = true }, function(out)
    if out.code ~= 0 then
      local msg = ('`chmod` returned %d'):format(out.code)
      if out.stderr ~= nil then
        local stderr = utils.str.trimchars(out.stderr, ' \t\n\r')
        if #stderr > 0 then
          msg = msg .. '\n  ' .. stderr
        end
      end
      vim.notify(msg, vim.log.levels.ERROR)
    end
  end)
end
nvim.create_user_command('Chmod', chmod, { nargs = '+' })
