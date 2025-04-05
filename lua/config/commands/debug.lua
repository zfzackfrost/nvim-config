---@param args vim.api.keyset.create_user_command.command_args
local function debug_start(args)
  --
end

vim.api.nvim_create_user_command('DebugStart', debug_start, {})
