---@param t vim.api.keyset.create_user_command.command_args
local function debug_start(t)
  vim.cmd.DapNew()
end
---@param t vim.api.keyset.create_user_command.command_args
local function debug_stop(t)
  vim.cmd.DapTermiate()
end

nvim.create_user_command('DebugStart', debug_start, {})
nvim.create_user_command('DebugStop', debug_stop, {})
