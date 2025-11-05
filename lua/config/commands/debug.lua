---@param t vim.api.keyset.create_user_command.command_args
local function debug_start(t)
  require('utils.vim.cmd').unimplemented(t)
end

nvim.create_user_command('DebugStart', debug_start, {})
