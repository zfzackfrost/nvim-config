local function debug_start()
  vim.cmd.DapNew()
end
local function debug_stop()
  vim.cmd.DapTerminate()
end

nvim.create_user_command('DebugStart', debug_start, {})
nvim.create_user_command('DebugStop', debug_stop, {})
