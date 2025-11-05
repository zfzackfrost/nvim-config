---@param t vim.api.keyset.create_user_command.command_args
local function clean_views(t)
  local views = vim.fs.find(function()
    return true
  end, { path = vim.go.viewdir, type = 'file', limit = math.huge })
  for _, v in ipairs(views) do
    vim.uv.fs_unlink(v)
  end
  if not t.smods.silent and not t.smods.emsg_silent then
    vim.notify(string.format('Cleaned %d views', #views), vim.log.levels.INFO, {})
  end
end

nvim.create_user_command('CleanViews', clean_views, { bar = true })
