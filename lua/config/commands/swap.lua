---@param t vim.api.keyset.create_user_command.command_args
local function clean_swap(t)
  local function impl()
    utils.fs.clear_dir(vim.go.directory, t.smods.silent or t.smods.emsg_silent)
  end
  Snacks.picker.util.confirm("Delete swap files (can't be undone)?", impl)
end

nvim.create_user_command('CleanSwap', clean_swap, { bar = true })
