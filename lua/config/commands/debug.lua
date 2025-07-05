---@param t vim.api.keyset.create_user_command.command_args
local function debug_start(t)
  require('utils.vim.cmd').unimplemented(t)
end

vim.api.nvim_create_user_command('DebugStart', debug_start, {})
