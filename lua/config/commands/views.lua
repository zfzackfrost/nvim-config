---@param t vim.api.keyset.create_user_command.command_args
local function clean_views(t)
  local function impl()
    local notify_fmt = utils.fs.make_clear_dir_notify_formatter('view')
    utils.fs.clear_dir(vim.go.viewdir, t.smods.silent or t.smods.emsg_silent, notify_fmt)
  end
  Snacks.picker.util.confirm("Delete view files (can't be undone)?", impl)
end

nvim.create_user_command('CleanViews', clean_views, { bar = true })
