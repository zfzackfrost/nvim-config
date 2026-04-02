---@param t vim.api.keyset.create_user_command.command_args
local function clean_views(t)
  local function impl()
    utils.fs.clear_dir(vim.go.viewdir, t.smods.silent or t.smods.emsg_silent)
  end
  Snacks.picker.util.confirm("Delete view files (can't be undone)?", impl)
end

nvim.create_user_command('CleanViews', clean_views, { bar = true })
