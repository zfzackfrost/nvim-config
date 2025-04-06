local M = {}

---@param t vim.api.keyset.create_user_command.command_args
function M.unimplemented(t)
  if t.smods.silent or t.smods.emsg_silent then
    return
  end
  vim.notify('Command has not been implemented yet!', vim.log.levels.WARN)
end

return M
