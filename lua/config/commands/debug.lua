local function debug_start()
  local impl = vim.b.debug_start_impl
  if impl ~= nil then
    impl()
  else
    vim.cmd.DapNew()
  end
end
local function debug_stop()
  local impl = vim.b.debug_stop_impl
  if impl ~= nil then
    impl()
  else
    vim.cmd.DapTerminate()
  end
end

nvim.create_user_command('DebugStart', debug_start, {})
nvim.create_user_command('DebugStop', debug_stop, {})
