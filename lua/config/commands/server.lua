vim.g.server_started = false

local function get_server_path()
  local cache_dir = vim.fn.stdpath('cache') --[[@as string]]
  return vim.fs.joinpath(cache_dir, 'serverpipe')
end

local function start_server()
  local p = get_server_path()
  if vim.uv.fs_stat(p) then
    vim.notify('Failed to start server:\nPipe already exists!', vim.log.levels.WARN, {})
    return
  end
  if not vim.g.server_started then
    vim.fn.serverstart(p)
    vim.notify(string.format('Started server:\n   %s', p), vim.log.levels.INFO, {})
  end
  vim.g.server_started = true
end

local function stop_server()
  local p = get_server_path()
  if not vim.uv.fs_stat(p) then
    vim.notify('Failed to stop server:\nPipe does not exists!', vim.log.levels.WARN, {})
    return
  end
  vim.fn.serverstop(p)
  vim.g.server_started = false
  vim.notify(string.format('Stopped server:\n   %s', p), vim.log.levels.INFO, {})
end

local function clean_server_pipe()
  local p = get_server_path()
  if vim.uv.fs_stat(p) then
    vim.uv.fs_unlink(p)
  end
end

vim.api.nvim_create_user_command('StartServer', start_server, { bar = true })
vim.api.nvim_create_user_command('StopServer', stop_server, { bar = true })
vim.api.nvim_create_user_command('CleanServerPipe', clean_server_pipe, { bar = true })
