vim.g.server_started = false

local function get_server_path()
  local cache_dir = vim.fn.stdpath('cache') --[[@as string]]
  return vim.fs.joinpath(cache_dir, 'serverpipe')
end

---@param t vim.api.keyset.create_user_command.command_args
local function start_server(t)
  if vim.g.server_started then
    return
  end
  local p = get_server_path()
  local silent = t.smods.silent or t.smods.emsg_silent
  if vim.uv.fs_stat(p) then
    if not silent then
      vim.notify('Failed to start server:\nPipe already exists!', vim.log.levels.WARN, {})
    end
    return
  end
  vim.fn.serverstart(p)
  if not silent then
    vim.notify(string.format('Started server:\n   %s', p), vim.log.levels.INFO, {})
  end
  vim.g.server_started = true
end

---@param t vim.api.keyset.create_user_command.command_args
local function stop_server(t)
  local p = get_server_path()
  local silent = t.smods.silent or t.smods.emsg_silent
  if not vim.uv.fs_stat(p) then
    if not silent then
      vim.notify('Failed to stop server:\nPipe does not exists!', vim.log.levels.WARN, {})
    end
    return
  end
  vim.fn.serverstop(p)
  vim.g.server_started = false
  if not silent then
    vim.notify(string.format('Stopped server:\n   %s', p), vim.log.levels.INFO, {})
  end
end

local function clean_server_pipe()
  local p = get_server_path()
  if vim.uv.fs_stat(p) then
    vim.uv.fs_unlink(p)
  end
end

nvim.create_user_command('StartServer', start_server, { bar = true })
nvim.create_user_command('StopServer', stop_server, { bar = true })
nvim.create_user_command('CleanServerPipe', clean_server_pipe, { bar = true })
